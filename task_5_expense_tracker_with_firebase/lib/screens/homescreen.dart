// ignore_for_file: unused_import, unused_local_variable

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_expense_tracker_with_firebase/screens/adddata.dart';
import 'package:task_5_expense_tracker_with_firebase/screens/loginscreen.dart';
import 'package:task_5_expense_tracker_with_firebase/screens/showdata.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int index = 1;
  final navigation_items = [
    Icon(Icons.add , size: 30,),
   
    Icon(Icons.home, size: 30,),
    
   

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        elevation: 1,
        title: Text('Expense Tracker'),
        centerTitle: true
        ,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
           child:ElevatedButton(onPressed: (){
              FirebaseAuth.instance.signOut();
              Get.off(()=>LoginScreen());
            }, child: Text('Log Out'))),
        ]
          )
        ,
       bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.blue,
        animationDuration: Duration(milliseconds: 300),
        items: navigation_items,
        index: index,
        onTap: (selectedIndex){
             setState(() {
               index = selectedIndex;
               print(index);
             });
        },
        height: 50,

        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: selectedpage(index: index),
        ),
       
    );

  }
  

}
Widget? selectedpage({required int index}) {
  
  Widget? widget;
  switch (index) {
    case 0:
      widget =  adddata();
      break;
    case 1:
      widget =  ShowData();
      break;
   
  }
  return widget;
  
}



