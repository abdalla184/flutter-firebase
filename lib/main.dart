
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/category/add.dart';
import 'package:flutter_application_1/note/viewnote.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/pages/signup.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp(
 //options:
// FirebaseOptions(
  //  apiKey: 'key',
  //  appId: 'id',
  // messagingSenderId: 'sendid',
  ///  projectId: 'myapp',
  //  storageBucket: 'myapp-b9yt18.appspot.com',
// )
 //);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   @override
void initState() {
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     home: (FirebaseAuth.instance.currentUser!=null
     &&FirebaseAuth.instance.currentUser!.emailVerified)
          ?Homepage():
           Login(),
  
     routes:{

       "signup"  : (context)  => Signup(),
       "login"   : (context)  => Login(),
       "homepage":(context)   => Homepage(),
       "add"     :(context)   => Add(),

  },
  
      
     
    
    );
  }
}
