import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/category/edit.dart';
import 'package:flutter_application_1/note/viewnote.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List data = [];
  bool isloading = true;
  getdata() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("categories")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
    data.addAll(query.docs);
    isloading = false;

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
      floatingActionButton: FloatingActionButton(
          child: Text("add"),
          onPressed: () {
            Navigator.of(context).pushNamed("add");
          }),
      appBar: AppBar(
        title: const Text("home page"),
        backgroundColor: Colors.blue,
        actions: [
          MaterialButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (routes) => false);
              },
              child: Icon(Icons.exit_to_app))
        ],
      ),
      body:
       isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 160),
              itemCount: data.length,
              itemBuilder: (context, i) {
                return InkWell(
                    onDoubleTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Viewnote(categoryid: data[i].id)));
                    },
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Edit(
                            docid: data[i].id, oldname: data[i]["name"]);
                      }));
                    },
                    onLongPress: () {
                      FirebaseFirestore.instance
                          .collection("categories")
                          .doc(data[i].id)
                          .delete();
                    },
                    child: Card(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Image.network(
                                  "https://storage.googleapis.com/dopingcloud/blog/tr/2020/07/google-llc-3.png",
                                  height: 80,
                                ),
                              
                               Text("${data[i]['name']}",style: TextStyle(fontSize: 20),),
                              ],
                            ))));
              }),
    );
  }
}
