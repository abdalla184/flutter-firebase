import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custombutton.dart';
import 'package:flutter_application_1/component/customtextfield.dart';
import 'package:flutter_application_1/pages/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
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
                    "login",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 3,
                  ),
                  const Text(
                    "login to contious using the app",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  Container(
                    height: 30,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Customtextfield(
                    mycontroller: email,
                    hinttext: "enter your email",
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
                    validator: (val) {
                      if (val == "") {
                        return "can't be empty";
                      }
                    },
                    hinttext: "enter your password",
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () async {
                      if (email.text != null) {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email.text);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child:Container(
                      alignment: Alignment.topRight,
                     child:const Text(  "forget password?",
                      style: TextStyle(fontSize: 20),
                    
                    ), ) ,),
                    Container(
                    height: 20,  ),
                ],
              ),
            ),
            Custombutton(
                title: "log in",
                onpressed: () async {
                  print("xcccccccccccccccccc");
                  if (formstate.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                    if (credential.user!.emailVerified) {
                        Navigator.of(context).pushReplacementNamed("homepage");
                     } else {
                       FirebaseAuth.instance.currentUser!
                       .sendEmailVerification();
                     }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email!');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  }

                  //   AwesomeDialog(
                  //      context: context,
                  //    animType: AnimType.leftSlide,
                  //    headerAnimationLoop: false,
                  //    dialogType: DialogType.success,
                  ////    showCloseIcon: true,
                  //    title: 'Succes',
                  //    desc:
                  //        'Dialog description here..........',
                  //btnOkOnPress: () {
                  //debugPrint('OnClcik');
                  //},
                  //btnOkIcon: Icons.check_circle,
                  //onDismissCallback: (type) {
                  //  debugPrint('Dialog Dissmiss from callback $type');
                  //  },
                  //  ).show();
                }),
            Container(
              height: 40,
            ),
            MaterialButton(
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: Colors.red,
                onPressed: () {
                  signInWithGoogle();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "sign in with google",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Image.network(
                      width: 40,
                      "https://storage.googleapis.com/dopingcloud/blog/tr/2020/07/google-llc-3.png",
                    ),
                  ],
                )),
            Container(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("signup");
              },
              child: const Text.rich(TextSpan(children: [
                TextSpan(
                    text: "don't have an account ?",
                    style: TextStyle(fontSize: 20)),
                TextSpan(
                    text: "Register ",
                    style: TextStyle(fontSize: 20, color: Colors.amberAccent))
              ])),
            ),
          ],
        ),
      ),
    );
  }
}
