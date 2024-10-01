import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/Screens/admin_login_screen.dart';

import 'Widgets/CutomButton.dart';
class AdminLogoutScreen extends StatelessWidget {
  const AdminLogoutScreen({super.key});
  void _adminLogout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AdminLoginScreen(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 170,
            width: 170,
            decoration: BoxDecoration(
                color: Color(0xFF4DB6AC),
                borderRadius: BorderRadius.circular(90)
            ),
            child: Center(
              child: Icon(Icons.person,
                  size: 110,
                  color: Colors.white
              ),
            ),
          ),
          SizedBox(height: 50,),
          CustomButton(btnText: "Logout", onPressed:_adminLogout)
        ],
      ),
    );
  }
}
