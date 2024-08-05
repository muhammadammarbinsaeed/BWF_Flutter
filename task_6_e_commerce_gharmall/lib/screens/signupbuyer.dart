// ignore_for_file: unused_field, unused_local_variable, body_might_complete_normally_nullable, unused_import

import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_6_e_commerce_gharmall/screens/loginbuyer.dart';
import 'package:task_6_e_commerce_gharmall/screens/role.dart';
import 'package:task_6_e_commerce_gharmall/services/signupservices.dart';


class signupbuyer extends StatefulWidget {
  const signupbuyer({super.key});

  @override
  State<signupbuyer> createState() => _signupbuyerState();
}

class _signupbuyerState extends State<signupbuyer> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 
  }
  @override
  Widget build(BuildContext context) {
    print('buyersignup');
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
  
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80,left: 20,right: 20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Hello! Register to get started',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                 SizedBox(height: screensize.height*0.02,),
                 Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: TextFormField(
                            validator: (value){
                            if( value!.isEmpty){
                                 return 'This Field cannot be empty';
                            }
                          },
                        
                            controller: firstnamecontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide.none
                                ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 239, 246, 252),
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                              hintText: 'First Name'
                            ),
                             ),
                      ),
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 3),
                             child: TextFormField(
                                                       validator: (value){
                                                       if( value!.isEmpty){
                                 return 'This Field cannot be empty';
                                                       }
                                                     },
                             
                                                       controller: lastnamecontroller,
                                                       decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide.none
                                ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 239, 246, 252),
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                              hintText: 'Last Name'
                                                       ),
                             ),
                           ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
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
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 3),
                         child: TextFormField(
                          validator: (value){
                          if( value!.isEmpty){
                               return 'This Field cannot be empty';
                          }
                        },
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none
                              ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 239, 246, 252),
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                            hintText: 'Password'
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
                        onPressed: ()async{
                          if(_formkey.currentState!.validate()){
                           var firstname = firstnamecontroller.text.trim();
                              var secondname = lastnamecontroller.text.trim();
                              var email = emailcontroller.text.trim();
                              var password = passwordcontroller.text.trim();
                         var   role =  'buyer';
                             await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value)=>{
                                signupservices(firstname, secondname, email, password, role ),
                                log('User created'),
                                
                             });
                          }
                        }, 
                       child: Text('Register')
                       )
                
                    ],
                
                  ) 
                 ),
                 
                 Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',style: TextStyle(color: Colors.grey.shade600),),
                     Padding(
                       padding: const EdgeInsets.only(left: 3),
                       child: GestureDetector(
                        
                        onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginbuyer()));
                        },
                        child: Text('Login Now',style: TextStyle(color: Color.fromARGB(255,98, 107, 252),),)),
                     ),
                  ],
                  ),
                  )
              ],
            ),
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