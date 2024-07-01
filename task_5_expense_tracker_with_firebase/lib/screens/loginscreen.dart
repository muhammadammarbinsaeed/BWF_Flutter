// ignore_for_file: unused_local_variable

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_5_expense_tracker_with_firebase/screens/forgotpassword.dart';
import 'package:task_5_expense_tracker_with_firebase/screens/homescreen.dart';
import 'package:task_5_expense_tracker_with_firebase/screens/signupscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //     width: size.width * 0.7,
              //     height: size.height * 0.3,
              //     child: Image.asset('assets/images/expense_image.png')),
               Container(
                height: size.height*0.3,
                
                child: Lottie.asset('assets/lottie/welcomeanimation.json')),
              RichText(
                text: TextSpan(
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Welcome Back!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 40),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Let\'s Log in!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Track Your Monthly Expenses Efficiently',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 15),
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: TextFormField(
                          validator: emailValidate,
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        child: TextFormField(
                          obscureText: passwordVisible,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                 var loginemail = emailController.text.trim();
                                 var loginpassword = passwordController.text.trim();
                                 try {
                                 final   UserCredential userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginemail, password: loginpassword);
                                 final User? firebaseuser = userCredentials.user;
                                 if(firebaseuser!=null){
                                     Get.off(()=>homepage());
                                 }
                                 else {
                                  
                                 }
                                 } catch (e) {
                                  Get.defaultDialog(title: 'Please enter Correct email & password',
                                  titlePadding: EdgeInsets.only(top: 50),
                                  middleText: '',
                                  radius: 30,
                                  textConfirm: 'Ok',
                                  onConfirm: (){
                                    Get.back();

                                  }
                                  );
                                  print('Error: $e ');
                                   
                                 }
                                 
                                }
                              },
                              child: Text('Sign In'),
                            ),
                            SizedBox(width: size.width*0.22,),
                            ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotpasswordscreen()));
                          },
                          child: Text('Forgot Password'),
                        ),
                          ],
                        ),
                      ),
                    
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                              },
                              child: Text(
                                'Sign Up Now',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? emailValidate(String? value) {
    if (value!.isEmpty) {
      return 'This field cannot be empty';
    } else if (!EmailValidator.validate(value)) {
      return 'Email format is invalid';
    }
    return null;
  }
}
