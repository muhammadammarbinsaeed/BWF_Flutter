// ignore_for_file: unused_field, unused_local_variable, prefer_const_constructors, unused_import, body_might_complete_normally_nullable, unnecessary_null_comparison, avoid_single_cascade_in_expression_statements, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task_6_e_commerce_gharmall/providers.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:task_6_e_commerce_gharmall/screens/sellerview/sellerhomepage.dart';
import 'package:task_6_e_commerce_gharmall/screens/sellerview/storepage.dart';

class Addproductpage extends ConsumerStatefulWidget {
  const Addproductpage({super.key});

  @override
  ConsumerState<Addproductpage> createState() => _AddproductpageState();
}

class _AddproductpageState extends ConsumerState<Addproductpage> {
  User? currentuser = FirebaseAuth.instance.currentUser;
  File? _image;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final picker = ImagePicker();
  final _formkey = GlobalKey<FormState>();
  TextEditingController productnamecontroller = TextEditingController();
  TextEditingController productdescriptioncontroller = TextEditingController();
  TextEditingController productpricecontroller = TextEditingController();
  Future pickgalleryimage() async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (PickedFile != null) {
      _image = File(PickedFile.path);
      ref.read(imageprovider.notifier).state = _image;
    } else {
      print('No image picked');
    }
  }

  @override
  Widget build(BuildContext context) {
    File? imagefile = ref.watch(imageprovider);
    final variations = ref.watch(productvariation);
    final category = ref.watch(categoryprovider);
    final productownername = ref.watch(productowner);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 98, 107, 252),
        title: Text(
          'Add Your Product',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'Product Information',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600),
              )),
              GestureDetector(
                onTap: () {
                  pickgalleryimage();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                      height: 30.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(color: Colors.grey.shade300),
                              right: BorderSide(color: Colors.grey.shade300),
                              top: BorderSide(color: Colors.grey.shade300),
                              bottom: BorderSide(color: Colors.grey.shade300)),
                          shape: BoxShape.rectangle),
                      child: _image != null
                          ? Image.file(
                              imagefile!.absolute,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.image)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This Field cannot be empty';
                            }
                          },
                          controller: productnamecontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Color.fromARGB(255, 233, 236, 238),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                              hintText: 'Product Name'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            maxLines: 5,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This Field cannot be empty';
                              }
                            },
                            controller: productdescriptioncontroller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Color.fromARGB(255, 233, 236, 238),
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                                hintText: 'Product Description'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Color.fromARGB(255, 233, 236, 238),
                              ),
                              value: category,
                              items: <String>[
                                'Electronics',
                                'Home Accessories',
                                'Mobile Accessories',
                                'Clothing',
                                'Men wearing',
                                'Shoes',
                                'Toys',
                                'Beauty & Health'
                              ].map((e) {
                                return DropdownMenuItem(
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (value) {
                                ref.read(categoryprovider.notifier).state =
                                    value!;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This Field cannot be empty';
                              }
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: productpricecontroller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Color.fromARGB(255, 233, 236, 238),
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                                hintText: 'Product Price'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Variations',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CheckboxListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      activeColor:
                                          Color.fromARGB(255, 98, 107, 252),
                                      title: Text(
                                        'Small',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      value: variations.contains('Small'),
                                      onChanged: (value) {
                                        if (value!) {
                                          ref
                                              .read(productvariation.notifier)
                                              .state = [
                                            ...ref
                                                .read(productvariation.notifier)
                                                .state,
                                            'Small'
                                          ];
                                        } else {
                                          ref
                                                  .read(productvariation.notifier)
                                                  .state =
                                              ref
                                                  .read(
                                                      productvariation.notifier)
                                                  .state
                                                  .where((element) =>
                                                      element != 'Small')
                                                  .toList();
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckboxListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      activeColor:
                                          Color.fromARGB(255, 98, 107, 252),
                                      title: Text(
                                        'Medium',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      value: variations.contains('Medium'),
                                      onChanged: (value) {
                                        if (value!) {
                                          ref
                                              .read(productvariation.notifier)
                                              .state = [
                                            ...ref
                                                .read(productvariation.notifier)
                                                .state,
                                            'Medium'
                                          ];
                                        } else {
                                          ref
                                                  .read(productvariation.notifier)
                                                  .state =
                                              ref
                                                  .read(
                                                      productvariation.notifier)
                                                  .state
                                                  .where((element) =>
                                                      element != 'Medium')
                                                  .toList();
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckboxListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      activeColor:
                                          Color.fromARGB(255, 98, 107, 252),
                                      title: Text(
                                        'Large',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      value: variations.contains('Large'),
                                      onChanged: (value) {
                                        if (value!) {
                                          ref
                                              .read(productvariation.notifier)
                                              .state = [
                                            ...ref
                                                .read(productvariation.notifier)
                                                .state,
                                            'Large'
                                          ];
                                        } else {
                                          ref
                                                  .read(productvariation.notifier)
                                                  .state =
                                              ref
                                                  .read(
                                                      productvariation.notifier)
                                                  .state
                                                  .where((element) =>
                                                      element != 'Large')
                                                  .toList();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                            onPressed: () async {
                               var productname =
                                  productnamecontroller.text.trim();
                              var productdescription =
                                  productdescriptioncontroller.text.trim();
                              var productprice =
                                  productpricecontroller.text.trim();
                              var variationslist = variations;
                              var productcategory = category;
                              productownername.when(data: (userdata) async {
                                      final  name = userdata;
                                    final ownername =   name!.elementAt(0);
                                    bool upload = await uploaded(productname, productdescription, productprice, variationslist, productcategory, imagefile!,ownername['secondname']);
                             if(upload==true){
                              ref.invalidate(fetchingstoredata);
                              ref.invalidate(productvariation);
                              ref.invalidate(productProvider);
                             }

                              }, 
                              error: (error, stackTrace) => Text('Error: ${error.toString()}'), 
                              loading: () => Text(''),
                              );
                             
                            },
                            child: Text('Add Product'))
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<bool> uploaded(String productname,String productdescription,String productprice,List variationslist,String productcategory,File? imagefile, String ownername)async{
        bool isUploaded = false;
                             try {
                               if (productname != null) {
                               
                                firebase_storage.Reference ref =
                                    firebase_storage.FirebaseStorage.instance
                                        .ref('/Productimages/user_${currentuser!.uid}_${UniqueKey().toString()}');
                                firebase_storage.UploadTask uploadTask =
                                    ref.putFile(imagefile!.absolute);
                                await Future.value(uploadTask)
                                    .then((value) async {
                                  var newURL = await ref.getDownloadURL();
                                  var productiD = FirebaseFirestore.instance.collection('Products').doc().id;
                                  await FirebaseFirestore.instance
                                      .collection("Products")
                                      .doc(productiD)
                                      .set({
                                    'createdAt': DateTime.now(),
                                    'userID': currentuser!.uid,
                                    'productname': productname,
                                    'productdescription': productdescription,
                                    'productprice': productprice,
                                    'productcategory': productcategory,
                                    'productvariations': variationslist,
                                    'productimage': newURL.toString(),
                                    'productid': productiD,
                                    'ownername': ownername,
                                  });
                                });
                                isUploaded = true;
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Uploaded'),
                                        content:
                                            Text('Product Added Successfully'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Ok')),
                                        ],
                                      );
                                    });
                              }
                              
                             }
                             
                              catch (e) {
                               throw Exception('ERROR: $e');
                             }
      return isUploaded;                    
  }
}
