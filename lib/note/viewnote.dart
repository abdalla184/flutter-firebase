import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/note/addnote.dart';
import 'package:flutter_application_1/note/editnote.dart';

class Viewnote extends StatefulWidget {
  Viewnote({super.key, required this.categoryid});
  final String categoryid;

  @override
  State<Viewnote> createState() => _ViewnoteState();
}

class _ViewnoteState extends State<Viewnote> {
  List data = [];
  bool isloading = true;
  getdata() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("categories")
        //.where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .doc(widget.categoryid)
        .collection("note")
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Addnote(docid: widget.categoryid)));
            }),
        appBar: AppBar(
          title: const Text("note view"),
          backgroundColor: Colors.blue,
        ),
        body: WillPopScope(
            onWillPop: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("homepage", (Route) => false);
              return Future.value(false);
            },
            child: isloading
                ? CircularProgressIndicator()
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisExtent: 160),
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Editnote(
                                  notedocid: data[i].id,
                                  oldname: data[i]['note'],
                                  notecategoryid: widget.categoryid);
                            }));
                          },
                          onLongPress: ()async {
                            await FirebaseFirestore.instance
                                .collection("categories")
                                .doc(widget.categoryid)
                                .collection("note")
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
                                        height: 50,
                                      ),
                                      Text("${data[i]['note']}"),
                                    ],
                                  ))));
                    })));
  }
}
