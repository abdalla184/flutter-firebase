import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Customtextfield extends StatelessWidget {
  Customtextfield({super.key,required this.mycontroller ,
  required this.validator,required this.hinttext});
  TextEditingController mycontroller;
  final String? hinttext;
final  String?Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: mycontroller,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.grey[50]),
          filled: true,
          fillColor: Colors.grey[300],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.black, width: 50)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.black))),
    );
  }

}
