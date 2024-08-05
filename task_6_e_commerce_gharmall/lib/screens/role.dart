// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_6_e_commerce_gharmall/screens/loginbuyer.dart';
import 'package:task_6_e_commerce_gharmall/screens/loginseller.dart';


class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}
class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Device.orientation == Orientation.portrait? Image.asset('assets/1.png', height: 40.h,width: double.infinity,): Image.asset('assets/1.png', height: 40.h,width: double.infinity,),
               Device.orientation == Orientation.portrait? SizedBox(height: 5.h): SizedBox(height: 2.h),
               Padding(
                 padding: const EdgeInsets.only(left: 80,right: 15),
                 child: Text(
                  'Welcome to Our Ecommerce Store',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                               ),
               ),
              Device.orientation == Orientation.portrait? SizedBox(height: 5.h): SizedBox(height: 2.h),
              const Text(
                'Choose Your Role:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
               Device.orientation == Orientation.portrait? SizedBox(height: 5.h): SizedBox(height: 2.h),
              ElevatedButton(
                onPressed: () {
                  SharedPreferenceutils().setuserrole('seller');
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>loginseller()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor:  Color.fromARGB(255,98, 107, 252),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Seller'),
              ),
              Device.orientation == Orientation.portrait? SizedBox(height: 5.h): SizedBox(height: 2.h),
              ElevatedButton(
                onPressed: () {
                  SharedPreferenceutils().setuserrole('buyer');
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>loginbuyer()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor:  Color.fromARGB(255,98, 107, 252),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Buyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SharedPreferenceutils{
  String userrole = 'userrole';
  setuserrole(String role)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userrole', role);
  }
 Future<String?> getuserrole()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('userrole');
  }
}