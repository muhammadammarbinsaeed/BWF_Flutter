// ignore_for_file: unused_local_variable, unnecessary_null_comparison, non_constant_identifier_names, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class adddata extends StatefulWidget {
  const adddata({super.key});

  @override
  State<adddata> createState() => _adddataState();
}

class _adddataState extends State<adddata> {
  TextEditingController categorycontroller = TextEditingController();
   TextEditingController amountcontroller = TextEditingController();
   String amount_type = 'Expense';
   User? current_user = FirebaseAuth.instance.currentUser;
    TextEditingController datecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25)),
              width: size.width * 0.5,
              height: size.height * 0.07,
              child: Center(
                  child: Text(
                'Add Data',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                SizedBox(
                  height: size.height*0.1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: TextFormField(
                    controller: categorycontroller,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Write Category',
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
               Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,),
                  child: TextFormField(
                    controller: amountcontroller,
                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Add Amount',
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical:5),
                  child: TextFormField(
                    controller: datecontroller,
                    onTap: (){
                      _selectdate();
                    },
                    
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Date',
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                                       
                                        border: OutlineInputBorder(
                                          
                                            borderRadius: BorderRadius.circular(25)),
                                            enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(25),
                                            borderSide: BorderSide.none )),
                      value: amount_type,
                    items: <String>['Expense','Income'].map((e){
                          return DropdownMenuItem(child: Text(e),
                          value: e,);
                    }).toList(), 
                    onChanged: (value){
                      setState(() {
                        amount_type = value!;
                      });
                    }),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue
                      ),
                      onPressed: (){
                        var categorytype = categorycontroller.text.trim();
                        var amount = amountcontroller.text.trim();
                        var amounttype = amount_type;
                        var date = datecontroller.text;
                        if(categorytype!=null && amount !=null){
                          try {
                     FirebaseFirestore.instance.collection('Data').doc().set({
                       'createdAt': DateTime.now(),
                       'categorytype':categorytype,
                       'amount': amount,
                       'amounttype': amounttype,
                       'userID': current_user!.uid,
                       'date': date

                     });
                     Get.snackbar('Successful', 'Data Added Successfully');
                            
                          } catch (e) {
                            print('Error ${e}');
                            
                          }
                        }
                        
                      }, 
                      child: Text('Add',style: TextStyle(color: Colors.white),)
                      ),
                  )
                ],
              ),
          ],
        ),
      ),
          ),
          
        
    
    );
  }


  Future<void> _selectdate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));
    if (picked != null) {
      DateTime datevalue = picked;
      setState(() {
        datecontroller.text =
            picked.toString().split(" ")[0].split("-").reversed.join("/");
      });
    }
  }
}
