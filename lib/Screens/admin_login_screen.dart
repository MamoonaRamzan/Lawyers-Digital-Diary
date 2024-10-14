
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/Screens/Widgets/CutomButton.dart';
import 'package:lawyers_digital_diary/Screens/admin_home_page.dart';
import '../Utils/utils.dart';
class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  void _adminLogin(BuildContext context) {
    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value){
         Utils().toastMessage("Admin Login Successful");
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(
             builder: (context) => HomePage(),
           ),
         );
    }).onError((error, stackTrace){
      Utils().toastMessage(error.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  bool _isObscure =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
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
                    SizedBox(
                      height: 50,
                      width: 267,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Enter Email",
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
                        validator : (value){
                          if(value!.isEmpty){
                            return 'Enter email';
                          }
                          return null;
                        }
                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      height: 50,
                      width: 267,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController, // Accessing controller via widget
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                          validator : (value){
                            if(value!.isEmpty){
                              return 'Enter password';
                            }
                            return null;
                          }
                      ),
                    ),
                    SizedBox(height: 30,),
                    CustomButton(btnText: "Login", onPressed: (BuildContext context){
                      if(_formKey.currentState!.validate()){
                        _adminLogin(context);
                      }

                    })
                  ],
                
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
