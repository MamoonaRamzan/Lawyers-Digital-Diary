import 'package:flutter/material.dart';
import 'HexColor.dart';
class HeadingText extends StatelessWidget {
  String heading;
  HeadingText({super.key,required this.heading});

  @override
  Widget build(BuildContext context) {
    return Text(heading,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: HexColor('#042334'),
      //backgroundColor: Colors.pink,
    ),);
  }
}
