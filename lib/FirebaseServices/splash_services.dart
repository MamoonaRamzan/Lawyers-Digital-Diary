import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/Screens/admin_home_page.dart';
import 'package:lawyers_digital_diary/Screens/admin_login_screen.dart';
class SplashServices{
  void isLogin(BuildContext context){

    final _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;

    if(user != null) {
      Timer(const Duration(seconds: 3),
              () =>
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePage())));
    }
    else{
      Timer(const Duration(seconds: 3),
      () =>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AdminLoginScreen())));

    }

  }
}