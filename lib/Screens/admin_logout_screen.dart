/*import 'package:flutter/material.dart';
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
}*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/Screens/admin_home_page.dart';
import 'package:lawyers_digital_diary/Utils/utils.dart';

import 'admin_login_screen.dart';

class LogoutScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),

      ),
      elevation: 10,
      backgroundColor: Colors.white,
      surfaceTintColor: Color(0xFF4DB6AC),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.exit_to_app,
              size: 50,
              color: Colors.grey
            ),
            SizedBox(height: 20),
            Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                  color: Color(0xFF4DB6AC)
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4DB6AC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    _auth.signOut().then((value){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminLoginScreen(),
                        ),
                      );
                    }).onError((error, stackTrace){
                     Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    ); // Close the dialog
                  },
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


