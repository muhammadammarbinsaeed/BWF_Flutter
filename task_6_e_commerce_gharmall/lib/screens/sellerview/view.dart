// ignore_for_file: unused_local_variable, unused_import, duplicate_ignore

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task_6_e_commerce_gharmall/providers.dart';
import 'package:task_6_e_commerce_gharmall/screens/chip_widget.dart';
import 'package:task_6_e_commerce_gharmall/screens/favourites.dart';
import 'package:task_6_e_commerce_gharmall/screens/productdetails.dart';

class viewpage extends ConsumerStatefulWidget {
  const viewpage({super.key});

  @override
  ConsumerState<viewpage> createState() => _viewpageState();
}

class _viewpageState extends ConsumerState<viewpage> {
  List imagelist = [
    {"id": 1, "image_path": 'assets/images/image3.jpg'},
    {"id": 2, "image_path": 'assets/images/image4.jfif'},
    {"id": 3, "image_path": 'assets/images/image1.png'},
    {"id": 4, "image_path": 'assets/images/image2.png'},
  ];
  final CarouselController carouselController = CarouselController();
  User? currentuser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fetchFavoriteStatusProvider.future).then((favorites) {
        ref.read(favoriteStatusProvider.notifier).state = favorites;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final  userdata = ref.watch(fetchuserdata);
    final carouselindex = ref.watch(carouselprovider);
    final products = ref.watch(productProvider);
    final favoriteStatus = ref.watch(favoriteStatusProvider);
    final fetchFavoriteStatus = ref.watch(fetchFavoriteStatusProvider);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              height: 43.5.h,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: userdata.when(
                        data: (userdata) {
                          if (userdata == null) {
                            return Text('Hello',  style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),);
                          }
                          final data = userdata.elementAt(0);
                          return Text(
                            'Hello ' + data['firstname'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          );
                        },
                        error: (error, stackTrace) =>
                            Text('Error: ${error.toString()}'),
                        loading: () {
                          return Text('Hello',  style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Check Out Our Latest Deals!',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 20, right: 20, bottom: 15),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: InkWell(
                            onTap: () {},
                            child: CarouselSlider(
                                items: imagelist
                                    .map(
                                      (item) => Image.asset(
                                        item['image_path'],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    )
                                    .toList(),
                                carouselController: carouselController,
                                options: CarouselOptions(
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    autoPlay: true,
                                    aspectRatio: 2,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      ref
                                          .read(carouselprovider.notifier)
                                          .state = index;
                                    })),
                          ),
                        ),
                        Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imagelist.asMap().entries.map((entry) {
                                // print(entry);
                                // print(entry.key);
                                return GestureDetector(
                                  onTap: () => carouselController
                                      .animateToPage(entry.key),
                                  child: Container(
                                    width: carouselindex == entry.key ? 17 : 7,
                                    height: 7,
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: carouselindex == entry.key
                                            ? Colors.blue
                                            : Colors.teal),
                                  ),
                                );
                              }).toList(),
                            ))
                      ],
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
            child: Container(
              height: 50,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  for (final chipLabel in [
                    'All',
                    'Electronics',
                    'Home Accessories',
                    'Mobile Accessories',
                    'Clothing',
                    'Men wearing',
                    'Shoes',
                    'Toys',
                    'Beauty & Health'
                  ])
                    GestureDetector(
                      onTap: () {
                        final isSelected = chipLabel == ref.read(activeChip);
                        // Toggle active state and text color based on current selection
                        ref.read(activeChip.notifier).state =
                            isSelected ? '' : chipLabel;
                        ref.read(textcolor.notifier).update((state) =>
                            isSelected ? Colors.black : Colors.white);
                      },
                      child: ChipWidget(
                        chiplabel: chipLabel,
                        textcolor: ref.watch(activeChip) == chipLabel
                            ? ref.watch(textcolor)
                            : Colors.black,
                        activecolor: ref.watch(activeChip) == chipLabel
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 50.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  products.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return Center(
                            child: Text(
                          'No Product Found',
                          style: TextStyle(color: Colors.black),
                        ));
                      } else {
                        final productlist = data;
                        return Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                    (MediaQuery.of(context).size.height / 1.5),
                              ),
                              itemCount: productlist.length,
                              itemBuilder: (context, index) {
                                final product = productlist[index];
                                  final isFavorite = favoriteStatus[product.productID] ?? false;
                                return GestureDetector(
                                  
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>productdetailscreen(productdetails: productlist[index],)));
                                  },
                                  child: Card(
                                    
                                    color: Colors.white,
                                    child: Stack(
                                      children:[ Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Center(
                                              child: Image.network(
                                                productlist[index].productimage,
                                                width: 100,
                                                height: 80,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress != null) {
                                                    return child;
                                                  }
                                                  return child;
                                                },
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Text(
                                                      'Error loading image'); // Handle error displaying image
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 3,left: 10),
                                            child: Text(productlist[index].name, maxLines: 1,overflow: TextOverflow.ellipsis,),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 3),
                                            child: Text(productlist[index].price),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 3),
                                            child: Text(productlist[index].ownername),
                                          ),
                                         
                                        ],
                                      ),
                                      Positioned(
                                        right: 9,
                                        top: 8,
                                        child: GestureDetector(
                                          onTap:  () async {
                                                    if (isFavorite) {
                                                      // Remove from favorites
                                                      await removeFromFavorite(product.productID);
                                                    } else {
                                                      // Add to favorites
                                                         addtofavourite(
                                                        product.name,
                                                        product.description,
                                                        product.price,
                                                        product.variations,
                                                        product.userId,
                                                        product.productID,
                                                        product.productimage,
                                                        product.ownername
                                                      );
                                                    }
                                                    // Update favorite status
                                                    ref.read(favoriteStatusProvider.notifier).update((state) {
                                                      return {
                                                        ...state,
                                                        product.productID: !isFavorite
                                                      };
                                                    });
                                                  },
                                          child: Icon(
                                                    isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                                                    color: isFavorite ? Colors.red : null,
                                                  ),
                                          )
                                        )
                                      ]
                                      
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    },
                    error: (error, stackTrace) =>
                        Text('Error: ${error.toString()}'),
                    loading: () => CircularProgressIndicator(),
                  )
                ],
        
              ),
            ),
          )
        ],
      ),
    ));
  }

  Future<void> addtofavourite(String name, String description, String price, List variations, String userId, String productID, String productimage, String ownername)async {
    bool isadded = false;
    try {
       Favourites favourite = Favourites(productname: name, productdescription:  description, productprice: price, userId:  userId, ProductId:productID, productImage:productimage, ownername: ownername, productvariations: []);
    FirebaseFirestore.instance.collection('favourite').doc(currentuser!.uid).collection('Items').doc(productID).set(favourite.toMap()).then(
      (value){
        isadded = true;
      }
    );
      
    } catch (e) {
      
    }

  }
  Future<void> removeFromFavorite(String productID) async {
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
