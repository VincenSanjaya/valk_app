import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;
  const CustomTextFormField({Key? key, required this.onSaved, required this.hintText, required this.obscureText, required this.regEx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (_value) => onSaved(_value!),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      validator: (_value){
        return RegExp(regEx).hasMatch(_value!) ? null : "Invalid Input";
      },
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Color(0xFF202023),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: Colors.white54),
      )
    );
  }
}
