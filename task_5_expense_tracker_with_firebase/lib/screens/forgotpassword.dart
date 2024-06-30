import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_5_expense_tracker_with_firebase/screens/loginscreen.dart';


class forgotpasswordscreen extends StatefulWidget {
  const forgotpasswordscreen({super.key});

  @override
  State<forgotpasswordscreen> createState() => _forgotpasswordscreenstate();
}

class _forgotpasswordscreenstate extends State<forgotpasswordscreen> {
  TextEditingController forgotemail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(' Forgot Password '),
          centerTitle: true,
          // actions: [
          //   Icon(Icons.more_vert)
          // ],
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              height: 150,
              width: double.infinity,
              child: Lottie.asset("assets/lottie/forgotpasswordanimation.json"),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextFormField(
                validator: emailValidate,
                controller: forgotemail,
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
            )),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () async{
                       var forgotuseremail = forgotemail.text.trim();
                       try {
                        await  FirebaseAuth.instance.sendPasswordResetEmail(email: forgotuseremail)
                        .then((value) => {
                          Get.snackbar('Sent!', 'Email Sent to your Gmail account'),
                          Get.off(()=>LoginScreen())
                        });
                       } on FirebaseAuthException catch (e) {
                         print("Error $e");
                       }
                },
                child: const Text('Reset Password')),
          ]),
        )));
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


