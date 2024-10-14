import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/Screens/admin_login_screen.dart';
import 'package:lawyers_digital_diary/Screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lawyers Digital Diary',
      home: SplashScreen()
    );
  }
}


