import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custombutton.dart';
import 'package:flutter_application_1/component/customtextfield.dart';
import 'package:flutter_application_1/note/viewnote.dart';

class Editnote extends StatefulWidget {
  Editnote({
    super.key,
    required this.notedocid,
    required this.oldname,
    required this.notecategoryid,
  });
  final String notedocid;
  final String notecategoryid;
  final String oldname;

  @override
  State<Editnote> createState() => _EditnoteState();
}

class _EditnoteState extends State<Editnote> {
  TextEditingController note = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();

  void Editnote() async {
    CollectionReference categorynote = FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.notecategoryid)
        .collection("note");
    if (formstate.currentState!.validate()) {
      try {
        await categorynote.doc(widget.notedocid).update({"note": note.text});
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Viewnote(categoryid: widget.notecategoryid)),
            (Route) => false);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    note.text = widget.oldname;
    super.initState();
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("edit note"),
          backgroundColor: Colors.blue,
        ),
        body: Form(
          key: formstate,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Customtextfield(
                    mycontroller: note,
                    validator: (val) {
                      if (val == "") return "can't be empty";
                    },
                    hinttext: "enter new name"),
                SizedBox(
                  height: 20,
                ),
                Custombutton(
                    title: "edit note",
                    onpressed: () {
                      Editnote();
                    })
              ],
            ),
          ),
        ));
  }
}
