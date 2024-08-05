// ignore_for_file: unused_field, unused_local_variable, body_might_complete_normally_nullable, unused_label, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_6_e_commerce_gharmall/providers.dart';
import 'package:task_6_e_commerce_gharmall/screens/Forgotpassword.dart';
import 'package:task_6_e_commerce_gharmall/screens/buyerview/buyerhomepage.dart';
import 'package:task_6_e_commerce_gharmall/screens/loginseller.dart';
import 'package:task_6_e_commerce_gharmall/screens/role.dart';
import 'package:task_6_e_commerce_gharmall/screens/sellerview/sellerhomepage.dart';
import 'package:task_6_e_commerce_gharmall/screens/signupbuyer.dart';


class loginbuyer extends StatefulWidget {
  const loginbuyer({super.key});

  @override
  State<loginbuyer> createState() => _loginbuyerState();
}

class _loginbuyerState extends State<loginbuyer> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    print("buyer");
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 110,left: 20,right: 20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Welcome back! Glad to',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                 Text('see you, Again!',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                 SizedBox(height: screensize.height*0.05,),
                 Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
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
                          hintText: 'Enter your email'
                        ),
                        
                      ),
                       Consumer(
                         builder: (BuildContext context, WidgetRef ref, Widget? child) { 
                     final passwordvisible = ref.watch(passwordvisibleprovider);
                        return  Padding(
                           padding: const EdgeInsets.symmetric(vertical: 9),
                           child: TextFormField(
                            validator: (value){
                            if( value!.isEmpty){
                                 return 'This Field cannot be empty';
                            }
                          },
                            obscureText: passwordvisible,
                            controller: passwordcontroller,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: (){
                                ref.read(passwordvisibleprovider.notifier).state = !passwordvisible;
                              
                                },
                                icon: Icon(
                                  passwordvisible?Icons.visibility:Icons.visibility_off
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide.none
                                ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 239, 246, 252),
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                              hintText: 'Enter your password'
                            ),
                             ),
                         );
                          },
                         
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
                        onPressed: () async {
                         if(_formkey.currentState!.validate()){
                            var email = emailcontroller.text.trim();
                            var password = passwordcontroller.text.trim();
                            try {
                              final UserCredential usercredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                              final User? firebaseuser = usercredentials.user;
                              if(firebaseuser!=null){
                                FirebaseFirestore.instance.collection('Users').where('userID', isEqualTo:firebaseuser.uid).get().then((QuerySnapshot){
                                  if(QuerySnapshot.docs.isNotEmpty){
                                      final userdoc = QuerySnapshot.docs.first;
                                      final String role = userdoc['role'];
                                      if(role == 'buyer'){
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Buyerhomepage()));
                                      }
                                      else{
                                        FirebaseAuth.instance.signOut();
                                      }
                                  }
                                });
                              }
                              else{

                              }
                              
                            } catch (e) {
                              print('error : $e');
                              
                            }
                          }
                        }, 
                       child: Text('Login')
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
                          Navigator.push(context, MaterialPageRoute(builder: (Context)=>forgotpassword()));
                        }, 
                       child: Text('Forgot Password')
                       )
                
                    ],
                
                  ) 
                 ),
                 
                 Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',style: TextStyle(color: Colors.grey.shade600),),
                     Padding(
                       padding: const EdgeInsets.only(left: 3),
                       child: GestureDetector(
                        
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signupbuyer()));
                        },
                        child: Text('Register Now',style: TextStyle(color: Color.fromARGB(255,98, 107, 252),),)),
                     ),
                  ],
                  ),
                  ),
                    Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                    children: [
                      Expanded(child: Divider()),
                      Text('Want to Switch Role?',style:TextStyle(color: Colors.grey.shade600)),
                      Expanded(child: Divider())
                    ],
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
                          SharedPreferenceutils().setuserrole('seller');
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginseller()));
                        }, 
                       child: Text('Login As Seller')
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
