



// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

signupservices(String firstname,String secondname,String email,String password,String role)async{
User? user = FirebaseAuth.instance.currentUser;
try {
  await FirebaseFirestore.instance.collection('Users').doc(user!.uid).set(
    {
          'firstname' : firstname,
          'secondname' : secondname,
          'email': email,
        'password': password,
        'role': role,
        'createdAt':DateTime.now(),
        'userID':user.uid,

    }
  ).then((value)=>
    FirebaseAuth.instance.signOut(),
  );
  
} catch (e) {
  print('Error : $e');
  
}
}