// ignore_for_file: unused_local_variable

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
       Size screensize = MediaQuery.of(context).size;
     print('forgotpassword');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                    Lottie.asset('assets/lottie/forgotpassword.json',height: screensize.height*0.3),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: validatemail,
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none
                              ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 239, 246, 252),
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                            hintText: 'Email'
                          ),
                          
                        ),
                      ),
                      
                       ElevatedButton(
                        style: ButtonStyle(
                           foregroundColor: WidgetStateProperty.all(
                              Colors.white,
                           ),
                          backgroundColor: WidgetStateProperty.all(
                            Color.fromARGB(255,98, 107, 252),
                          ),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)
                                 )
                          )
                
                        ),
                        onPressed: (){
                          
                        }, 
                       child: Text('Reset Password')
                       )
                
                    ],
                
                  ) 
                 ),
            ),
          ),
        );
      
  }
   String? validatemail(String? value) {
    if (value!.isEmpty) {
      return 'This field cannot be empty';
    }
    if (EmailValidator.validate(value)) {
      // print('valid email');
    } else {
      return 'Please enter valid email';
    }
    return null;
  }
}