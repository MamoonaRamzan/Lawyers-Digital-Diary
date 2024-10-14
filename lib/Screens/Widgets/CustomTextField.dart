import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintTxt;
  final TextEditingController controller;
  CustomField({required this.hintTxt, required this.controller});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 267,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintTxt,
          hintStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 15,
            color: Color(0xff41BFAA),
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Color(0xff41BFAA),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Color(0xff41BFAA),
            ),
          ),
        ),
      ),
    );
  }
}
