import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custombutton.dart';
import 'package:flutter_application_1/component/customtextfield.dart';

class Edit extends StatefulWidget {
  Edit({super.key, required this.docid, required this.oldname});
  final String docid;
  final String oldname;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();

  void editcategory() async {
    CollectionReference categories =
        FirebaseFirestore.instance.collection("categories");
    if (formstate.currentState!.validate()) {
      try {
        categories.doc(widget.docid).update({"name": name.text});
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (Route) => false);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
   name.text=widget.oldname ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         title: Text("edit category"),
          backgroundColor: Colors.blue,
        ),
        body: Form(
      key: formstate,
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Customtextfield(
                mycontroller: name,
                validator: (val) {
                  if (val == "") return "can't be empty";
                },
                hinttext: "enter new name"),
                  SizedBox(height: 20,),
            Custombutton(
                title: "edit",
                onpressed: () {
                  editcategory();
                })
          ],
        ),
      ),
    ));
  }
}
