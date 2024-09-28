import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custombutton.dart';
import 'package:flutter_application_1/component/customtextfield.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  CollectionReference categories =
        FirebaseFirestore.instance.collection("categories");
  void addcategory() async {
  
    if (formstate.currentState!.validate()) {
      try {
        DocumentReference response = await categories.add(
            {"name": name.text, "id": FirebaseAuth.instance.currentUser!.uid});
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (Route) => false);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("add category"),
          backgroundColor: Colors.blue,
        ),
        body: Form(
          key: formstate,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Customtextfield(
                    mycontroller: name,
                    validator: (val) {
                      if (val == "") return "can't be empty";
                    },
                    hinttext: "enter name"),
                Container(
                  height: 20,
                ),
                
                 Custombutton(
                    title: "Add",
                   onpressed: () {
                      addcategory();
                    print("----------jjjjjj-------------------------");
                 })
              ],
            ),
          ),
        ));
  }
}
