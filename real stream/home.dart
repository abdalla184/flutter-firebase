import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/real%20stream/addex.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List data = [];
   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
   .collection('categories').snapshots();
  getdata() async {
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection("categories").get();
    data.addAll(query.docs);

    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("rael stream"),
          backgroundColor: Colors.blue,
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
        
        }),
        body: Container(child: StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

         return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, i) {
            return InkWell(
                onTap: () {
                  // Create a reference to the document the transaction will use
                  DocumentReference documentReference = FirebaseFirestore
                      .instance
                      .collection('categories')
                      .doc(data[i].id);

                  FirebaseFirestore.instance
                      .runTransaction((transaction) async {
                        // Get the document
                        DocumentSnapshot snapshot =
                            await transaction.get(documentReference);

                        if (snapshot.exists) {
                          var snapshotData = snapshot.data();

                          // Update the follower count based on the current count
                          // Note: this could be done without a transaction
                          // by updating the population using FieldValue.increment()
                          if (snapshotData is Map<String, dynamic>) {
                            int money = snapshotData['money'] + 50;

                            // Perform an update on the document
                            transaction
                                .update(documentReference, {'money': money});

                            // Return the new count
                            return money;
                          }
                        }
                      })
                      .then((value) => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Home();
                          })))
                      .catchError((error) =>
                          print("Failed to update user followers: $error"));
                },
                child: Card(
                  child: ListTile(
                    title: Text("${snapshot.data!.docs[i]["name"]}"),
                    subtitle: Text("${snapshot.data!.docs[i]["age"]}"),
                    trailing: Text("${snapshot.data!.docs[i]["money"]}\$"),
                  ),
                )); 
          },
        );
        }))
        );
  }
}

