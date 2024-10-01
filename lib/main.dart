import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/Screens/admin_login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lawyers Digital Diary',
      home: AdminLoginScreen()
    );
  }
}


