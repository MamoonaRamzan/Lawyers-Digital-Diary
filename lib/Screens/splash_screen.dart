import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/FirebaseServices/splash_services.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Lawyers Digital Diary',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),

        ),
      ),
    );
  }
}
