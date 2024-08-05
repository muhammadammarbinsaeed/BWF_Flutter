// ignore_for_file: unused_local_variable, unused_result, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_gharmall/providers.dart';
import 'package:task_6_e_commerce_gharmall/screens/productdetails.dart';
import 'package:task_6_e_commerce_gharmall/screens/sellerview/view.dart';

class favouritescreen extends ConsumerStatefulWidget {
  const favouritescreen({super.key});

  @override
  ConsumerState<favouritescreen> createState() => _favouritescreenState();
}

class _favouritescreenState extends ConsumerState<favouritescreen> {
  User? currentuser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final favouritesAsyncValue = ref.watch(fetchfavourites);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        centerTitle: true,
      ),
      body: favouritesAsyncValue.when(
          data: (favourites) {
            if (favourites!.isEmpty) {
              return Center(child: Text('No favourites found.'));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.5),
              ),
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final favourite = favourites[index];
                return GestureDetector(
                  onTap: (){
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>productdetailscreen(productdetails: favourite,)));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Center(
                              child: Image.network(
                            favourite.productImage,
                            width: 100,
                            height: 80,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress != null) {
                                return child;
                              }
                              return child;
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Text(
                                  'Error loading image'); // Handle error displaying image
                            },
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 8),
                          child: Center(
                              child: Text(
                            favourite.productname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 3),
                          child: Center(child: Text(favourite.productprice)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 3),
                          child: Center(child: Text(favourite.ownername)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          error: (e, st) => Center(child: Text('Error: ${e.toString()}')),
          loading: () => Center(child: CircularProgressIndicator())),
    );
  }
   
}
