import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custombutton.dart';
import 'package:flutter_application_1/component/customtextfield.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _signupState();
}

class _signupState extends State<Signup> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                ),
                Center(
                    child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.grey,
                  ),
                  height: 80,
                  width: 80,
                  child: Image.network(
                    "https://www.pngall.com/wp-content/uploads/13/ICQ-Symbol-PNG-File.png",
                    width: 50,
                  ),
                )),
                Container(
                  height: 20,
                ),
                const Text(
                  "sign up",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 3,
                ),
                const Text(
                  "sign up to contious using the app",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                Container(
                  height: 30,
                ),
                const Text(
                  "username",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Customtextfield(
                  mycontroller: username,
                  hinttext: "enter your username",
                  validator: (val) {
                    if (val == "") {
                      return "can't be empty";
                    }
                  },
                ),
                Container(
                  height: 30,
                ),
                const Text(
                  "email",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Customtextfield(
                  mycontroller: email,
                  hinttext: "entyer your email",
                  validator: (val) {
                    if (val == "") {
                      return "can't be empty";
                    }
                  },
                ),
                Container(
                  height: 30,
                ),
                const Text(
                  "password",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Customtextfield(
                  mycontroller: password,
                  hinttext: "entyer your password",
                  validator: (val) {
                    if (val == "") {
                      return "can't be empty";
                    }
                  },
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: const Text(
                    "forget password?",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  height: 20,
                ),
              ],
            ),
            Custombutton(
                title: "sign up",
                onpressed: () async {
                  //    if (formstate.currentState!.validate() ) {
                  print("ddddddddddddddddddd");
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );

                    Navigator.of(context).pushReplacementNamed("login");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print("error!! $e");
                  }
                  //  }
                }),
            Container(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("login");
              },
              child: Text.rich(const TextSpan(children: [
                TextSpan(
                    text: "Have an account ?", style: TextStyle(fontSize: 20)),
                TextSpan(
                    text: "login ",
                    style: TextStyle(fontSize: 20, color: Colors.amberAccent))
              ])),
            ),
          ],
        ),
      ),
    );
  }
}
