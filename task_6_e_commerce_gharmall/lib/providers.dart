
// ignore_for_file: unused_local_variable, unnecessary_cast

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_gharmall/screens/carts.dart';
import 'package:task_6_e_commerce_gharmall/screens/favourites.dart';
import 'package:task_6_e_commerce_gharmall/screens/products.dart';
import 'package:task_6_e_commerce_gharmall/screens/user.dart';
import 'package:task_6_e_commerce_gharmall/screens/ordermodelclass.dart';
final passwordvisibleprovider = StateProvider<bool>((ref){
   return true;
});
final passwordvisibleseller = StateProvider<bool>((ref){
   return true;
});
final navbarProvider = StateProvider<int>((ref){
  return 0;
});
final imageprovider = StateProvider<File?>((ref){
  return File(''); 

});
final productvariation = StateProvider<List<String>>((ref){
  return [];
});
final categoryprovider = StateProvider((ref){
return 'Electronics';
});
final fetchingstoredata = FutureProvider((ref) async {
  User? currentuser = FirebaseAuth.instance.currentUser;
  if (currentuser == null) {
    return [];
  }
  final querysnapshot = await FirebaseFirestore.instance
      .collection('Products')
      .where('userID', isEqualTo: currentuser.uid)
      .get();
  final products =
      querysnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
  return products;
});
final fetchuserdata = FutureProvider.autoDispose((ref)async{
User? currentappuser = FirebaseAuth.instance.currentUser;
if(currentappuser==null){
  return null;
}
final QuerySnapshot = await FirebaseFirestore.instance.collection('Users').where('userID',isEqualTo: currentappuser.uid).get();
final userdata = QuerySnapshot.docs.map((doc)=>user.fromSnapshot(doc).toMap());
return userdata;
});
final carouselprovider = StateProvider((ref){
  return 0;
});
final textcolor = StateProvider((ref) => Colors.black);
final activeChip = StateProvider((ref) => '');

final productProvider = FutureProvider<List<Product>>((ref) async {
  // Watch the activeChip provider to determine filtering criteria
  final chipLabel = ref.watch(activeChip);

  // Fetch QuerySnapshot from Firestore based on chip selection
  final querySnapshot = await FirebaseFirestore.instance
      .collection('Products')
      .where('productcategory', isEqualTo: chipLabel.isEmpty || chipLabel == 'All' ? null : chipLabel)
      .get();

  // Handle potential errors (optional but recommended)
  try {
    // Extract documents and map to Product objects
    final products = querySnapshot.docs
        .map((doc) => Product.fromSnapshot(doc))
        .toList();
    return products;
  } on FirebaseException catch (e) {
    // Handle Firebase errors (e.g., network issues, permission errors)
    print("Error fetching products: $e");
    return []; // Or throw an exception for further handling
  } catch (e) {
    // Handle other unexpected errors
    print("An unexpected error occurred: $e");
    return []; // Or throw an exception for further handling
  }
});
final productowner = FutureProvider((ref)async{
User? currentappuser = FirebaseAuth.instance.currentUser;
if(currentappuser==null){
  return null;
}
final QuerySnapshot = await FirebaseFirestore.instance.collection('Users').where('userID',isEqualTo: currentappuser.uid).get();
final userdata = QuerySnapshot.docs.map((doc)=>user.fromSnapshot(doc).toMap());
return userdata;
});
final quantityprovider =  StateProvider.autoDispose((ref){
return 1;
});
final productscreenvariationsprovider = StateProvider.autoDispose(
  (ref){
      return '';
  }
);
final cartbuttontextprovider = StateProvider.autoDispose((ref){
       return 'Add to Cart';
});

final favoriteStatusProvider = StateProvider.autoDispose<Map<String, bool>>(
  (ref) => {}
  );
  final fetchFavoriteStatusProvider = FutureProvider.autoDispose<Map<String, bool>>((ref) async {
  User? currentuser = FirebaseAuth.instance.currentUser;
  if (currentuser == null) return {};
  final snapshot = await FirebaseFirestore.instance
      .collection('favourite')
      .doc(currentuser.uid)
      .collection('Items')
      .get();

  final favorites = {for (var doc in snapshot.docs) doc.id: true};
  return favorites;
});



final fetchfavourites = FutureProvider.autoDispose((ref) async {
User? currentappuser = FirebaseAuth.instance.currentUser;
if(currentappuser==null){
  return null;
}
final QuerySnapshot =await FirebaseFirestore.instance
      .collection('favourite')
      .doc(currentappuser.uid)
      .collection('Items')
      .get();
 return QuerySnapshot.docs.map((doc) => Favourites.fromMap(doc.data() as Map<String, dynamic>)).toList();
});
final fetchcarts = FutureProvider.autoDispose((ref) async {
User? currentappuser = FirebaseAuth.instance.currentUser;
if(currentappuser==null){
  return null;
}
final QuerySnapshot =await FirebaseFirestore.instance
      .collection('cart')
      .doc(currentappuser.uid)
      .collection('Items')
      .get();
 return QuerySnapshot.docs.map((doc) => Cart.fromMap(doc.data() as Map<String, dynamic>)).toList();
});
final cartprice = StateProvider.autoDispose((ref){
  return 0;
});
final fetchrecentorders = FutureProvider.autoDispose((ref) async {
User? currentappuser = FirebaseAuth.instance.currentUser;
if(currentappuser==null){
  return null;
}
final QuerySnapshot =await FirebaseFirestore.instance
      .collection('orders').where('userId', isEqualTo: currentappuser.uid).get();
 return QuerySnapshot.docs.map((doc) => order.fromMap(doc.data() as Map<String, dynamic>)).toList();
});

final userProvider = FutureProvider<user?>((ref) async {
  // Fetch user data from Firebase
  final users = FirebaseAuth.instance.currentUser;
  if (users == null) return null; // Handle no signed-in user
  final userDoc = await FirebaseFirestore.instance.collection('Users').doc(users!.uid).get();
  if (!userDoc.exists) return null; // Handle user data not found
  return user.fromMap(userDoc.data() as Map<String, dynamic>);
});

final userStateProvider = StateNotifierProvider<userNotifier, user?>((ref) => userNotifier());

class userNotifier extends StateNotifier<user?> {
  userNotifier() : super(null); 


  void updateUser(user updatedUser) {
    state = updatedUser;
  }
}
