import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/Screens/Widgets/CutomButton.dart';
import 'package:lawyers_digital_diary/Screens/Widgets/PasswordField.dart';
import 'package:lawyers_digital_diary/Screens/admin_home_page.dart';
import 'Widgets/CustomTextField.dart';
class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});
  void _adminLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
            
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
                  SizedBox(height: 40,),
                  CustomField(hintTxt: "Enter Email"),
                  SizedBox(height: 20,),
                  PasswordField(),
                  SizedBox(height: 30,),
                  CustomButton(btnText: "Login", onPressed:_adminLogin)
                ],
            
              ),
            ),
          ),
        ),
      ),
    );
  }
}
