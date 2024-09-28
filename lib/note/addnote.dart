import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custombutton.dart';
import 'package:flutter_application_1/component/customtextfield.dart';
import 'package:flutter_application_1/note/viewnote.dart';

class Addnote extends StatefulWidget {
  Addnote({super.key, required this.docid});
  final String docid;

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  TextEditingController note = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();

  void  Addnote() async {
    CollectionReference categories = FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.docid)
        .collection("note");
    if (formstate.currentState!.validate()) {
      try {
        await categories.add({
          "note":note.text,
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Viewnote(categoryid:widget.docid);
        }));
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("addnote"),
          backgroundColor: Colors.blue,
        ),
        body: Form(
          key: formstate,
          child: Container(
            child: Column(
              children: [
                  SizedBox(height: 20,),
                Customtextfield(
                    mycontroller: note,
                    validator: (val) {
                      if (val == "") return "can't be empty";
                    },
                    hinttext: "enter name"),
                      SizedBox(height: 20,),
                Custombutton(
                    title: "Add",
                    onpressed: () {
                      Addnote();
                    })
              ],
            ),
          ),
        ));
  }
}
