// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_6_e_commerce_gharmall/firebase_options.dart';
import 'package:task_6_e_commerce_gharmall/screens/buyerview/buyerhomepage.dart';
import 'package:task_6_e_commerce_gharmall/screens/loginbuyer.dart';
import 'package:task_6_e_commerce_gharmall/screens/loginseller.dart';
import 'package:task_6_e_commerce_gharmall/screens/role.dart';
import 'package:task_6_e_commerce_gharmall/screens/sellerview/sellerhomepage.dart';
String? whichscreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

);
SharedPreferences prefs = await SharedPreferences.getInstance();
whichscreen = prefs.getString('userrole');

  runApp(
    const ProviderScope(
    child:  MyApp()
    )
    );
}
class MyApp extends StatefulWidget {
  
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  user = FirebaseAuth.instance.currentUser;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return ResponsiveSizer(
      builder: (BuildContext , Orientation , ScreenType ) { 
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: whichscreen==null?RoleSelectionScreen():checkscreen(),
      ); 

      },
      
    );
  }

  checkscreen(){
      if(whichscreen=='seller' && user!=null){
        return Sellerhomepage();
      }
      else if(whichscreen=='seller' && user==null){
           return loginseller();
      }
      else if(whichscreen=='buyer' && user!=null){
        return Buyerhomepage();
      }
      else if(whichscreen=='buyer' && user==null){
           return loginbuyer();
      }
      
      else{
        RoleSelectionScreen();
      }
  }
}

