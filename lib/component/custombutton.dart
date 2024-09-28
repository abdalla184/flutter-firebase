import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
   Custombutton ({super.key,required this.onpressed, required this.title});
  final String title;
  final void Function()? onpressed ;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        color: Colors.blue,
        onPressed:onpressed,
        child: Text(
          title,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ));
  }
}
