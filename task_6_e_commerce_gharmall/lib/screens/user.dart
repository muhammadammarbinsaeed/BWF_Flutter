// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_local_variable, unused_import

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class user {
  final String email;
  final String firstname;
  final String secondname;
  final String role;
  user({
    required this.email,
    required this.firstname,
    required this.secondname,
    required this.role,
  });
  
  // Add other product fields as needed

 

  



  user copyWith({
    String? email,
    String? firstname,
    String? secondname,
    String? role,
  }) {
    return user(
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      secondname: secondname ?? this.secondname,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstname': firstname,
      'secondname': secondname,
      'role': role,
    };
  }

  factory user.fromSnapshot(DocumentSnapshot snapshot){
    return user(
      email: snapshot['email'] as String,
      firstname: snapshot['firstname'] as String,
      secondname: snapshot['secondname'] as String,
      role: snapshot['role'] as String,
    );
  }
  factory user.fromMap(Map<String, dynamic> map) {
    return user(
      email: map['email'] as String,
      firstname: map['firstname'] as String,
      secondname: map['secondname'] as String,
      role:map['role'] as String,

    );
  }
}


