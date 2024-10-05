import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/real%20stream/home.dart';

class Addex extends StatefulWidget {
  const Addex({super.key});

  @override
  State<Addex> createState() => _AddexState();
}

class _AddexState extends State<Addex> {
  TextEditingController name = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
  void add() async {
    try {
      DocumentReference response = await categories.add({
        "name": name.text,
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return Home();
      }), (Route) => false);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("add"),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: "enter name",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 20),
                    borderRadius: BorderRadius.all(Radius.circular(60))),
                filled: true,
                fillColor: Colors.grey,
                enabled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 80),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () {
                add();
              },
              height: 60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              color: Colors.blue,
              child: Text(
                "add",
              ),
            )
          ],
        ));
  }
}
