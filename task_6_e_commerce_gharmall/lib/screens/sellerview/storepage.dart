// ignore_for_file: sort_child_properties_last, unused_local_variable, unused_import, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task_6_e_commerce_gharmall/providers.dart';
import 'package:task_6_e_commerce_gharmall/screens/products.dart';
import 'package:task_6_e_commerce_gharmall/screens/sellerview/addproductpage.dart';
import 'package:task_6_e_commerce_gharmall/screens/user.dart';


class storepage extends ConsumerStatefulWidget {
  const storepage({super.key});

  @override
  ConsumerState<storepage> createState() => _storepageState();
}

class _storepageState extends ConsumerState<storepage> {
  @override
  Widget build(BuildContext context) {
      final products = ref.watch(fetchingstoredata);
     final  userDataSnapshot =  ref.watch(fetchuserdata);
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: 100.w,
          height: 70,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 199, 203, 253),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              userDataSnapshot.when(
                    data: (userData) {
                      if (userData == null) {
                        return Text(
                          '',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        );
                      }
                    final data =   userData.elementAt(0);
                      return Text(
                        'Hello ' + data['secondname'],
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      );
                    }, loading: () {return CircularProgressIndicator(); }, 
                    error:(error, stackTrace) => Text('Error: ${error.toString()}'),
                    
              ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Your Listed Products',
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 199, 203, 253),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        products.when(
                            data: (data) {
                              if (data.isEmpty) {
                                return Center(child: Text('No Product Found',style: TextStyle(color: Colors.black),));
                              } else {
                                final productlist = data;
                                return Expanded(
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemCount: productlist.length,
                                      
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color: Colors.white,
                                          child: Dismissible(
                                            key: UniqueKey(),
                                            background: Container(
                                                                color: Colors.red,
                                                                alignment: Alignment.centerRight,
                                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                child: Icon(Icons.delete, color: Colors.white),
                                                              ),
                                            direction: DismissDirection.endToStart,
                                            onDismissed: (direction) async{
                                                               bool isdeleted = await deleteProduct(productlist[index].productID);

                                                               if(isdeleted==true){
                                                                await removeFromFavorite(productlist[index].productID);
                                                                 ref.invalidate(fetchingstoredata);
                                                                 ref.invalidate(productProvider);
                                                               }
                                                               
                                                              },
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: Image.network(
                                                    productlist[index].productimage,
                                                    width: 100,
                                                    height: 80,
                                                    loadingBuilder: (context, child,
                                                        loadingProgress) {
                                                      if (loadingProgress != null){
                                                      return child; 
                                                      }
                                                      return child;
                                                    },
                                                    errorBuilder: (context, error,
                                                        stackTrace) {
                                                      return Text(
                                                          'Error loading image'); // Handle error displaying image
                                                    },
                                                  ),
                                                ),
                                                Padding(padding: EdgeInsets.only(top: 3),
                                                child: Text(productlist[index].name, maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                ),
                                                 Padding(padding: EdgeInsets.only(top: 3),
                                                child: Text(productlist[index].price),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              }
                            },
                            error: (error, stackTrace) => Text('Error: ${error.toString()}'),
                            loading: () => CircularProgressIndicator(),
                            )
                      ],
                    ),
                    
                  ),
                  height: 50.h,
                ),
                Container(
                    width: 100.w,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Want to Add More Products ?',
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  foregroundColor: WidgetStateProperty.all(
                                    Colors.white,
                                  ),
                                  backgroundColor: WidgetStateProperty.all(
                                    Color.fromARGB(255, 98, 107, 252),
                                  ),
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7)))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Addproductpage()));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Add more Products'),
                                  Icon(Icons.arrow_forward)
                                ],
                              ))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    ));
  }
  Future<bool> deleteProduct(String productId) async {
    bool isdeleted = false;
    try {
      await FirebaseFirestore.instance.collection('Products').doc(productId).delete();
      // Show success message or refresh the list
      isdeleted = true;
    } catch (e) {
      // Handle errors
      
    }
    return isdeleted;
  }
   Future<void> removeFromFavorite(String productID) async {
    User? currentuser = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('favourite')
          .doc(currentuser!.uid)
          .collection('Items')
          .doc(productID)
          .delete();
    } catch (e) {
      // Handle error
    }
  }
}



