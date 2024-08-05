// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types, must_be_immutable, unused_local_variable, unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task_6_e_commerce_gharmall/providers.dart';
import 'package:task_6_e_commerce_gharmall/screens/carts.dart';

class productdetailscreen extends ConsumerStatefulWidget {
  var productdetails;
  productdetailscreen({
    Key? key,
    required this.productdetails,
  }) : super(key: key);

  @override
  ConsumerState<productdetailscreen> createState() => _productdetailscreenState();
}

class _productdetailscreenState extends ConsumerState<productdetailscreen> {
  User? currentuser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
      String  userid = currentuser!.uid;
    var Quantity = ref.watch(quantityprovider);
    List<dynamic> variations = widget.productdetails.variations.toList();
    final selectedvariation = ref.watch(productscreenvariationsprovider);
    final buttontext = ref.watch(cartbuttontextprovider);
    print(selectedvariation);
    //print(variations.first);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Image.network(
                  widget.productdetails.productimage,
                  width: double.infinity,
                 
                  height: 45.h,
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
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 7,left:20,right: 20),
              child: Text(widget.productdetails.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
              maxLines: 3,overflow: TextOverflow.ellipsis,
                                      )
                                      ),
                                      Padding(
              padding: EdgeInsets.only(top:0,left:20,right: 20),
              child: Text(widget.productdetails.description,style: TextStyle(fontSize: 13,),
               maxLines: 5,overflow: TextOverflow.ellipsis,
                                      )
                                      ),
           
          
          
          
                                      Padding(padding: EdgeInsets.only(top:0,left:20,right: 20),
                                      child: Text(widget.productdetails.price + ' PKR',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                                      ),
          
                                      Padding(
              padding: const EdgeInsets.only(top:0,left:20,right: 20),
              child: widget.productdetails.variations.isNotEmpty?
              DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 233, 236, 238),
                                ),
                                value: selectedvariation.isNotEmpty ? selectedvariation :variations.first,
                                items: variations.map((e) {
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
                               ref.read(productscreenvariationsprovider.notifier).state =value.toString();
                                })
              :Text('No variations',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),)
             ),
                Padding(
                  padding: const EdgeInsets.only(top:0,left:20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Quantity',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                              Row(
                                children: [
                                            IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () =>Quantity>1?ref.read(quantityprovider.notifier).state = --Quantity:ref.read(quantityprovider.notifier).state = Quantity,
                              ),
                               Text('$Quantity'),
                              IconButton(
                                icon: Icon(Icons.add),
                                  onPressed: () => ref.read(quantityprovider.notifier).state = ++Quantity,
                              )
                                ],
                              ),
                            ],
                          ),
                          
                ),
                Padding(
                  padding: EdgeInsets.only(top:0,left:20,right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Color.fromARGB(255,98, 107, 252),
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            Colors.white
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                            )
                          )
                        ),
                        onPressed: () async {
                          String productname = widget.productdetails.name;
                          String productdescription = widget.productdetails.description;
                         String productprice = widget.productdetails.price;
                          String  productvariation = selectedvariation;
                          int quantity = Quantity;
                          String productid = widget.productdetails.productID;
                          String ownerid = widget.productdetails.userId;
                          String ownername = widget.productdetails.ownername;
                         int price =(quantity*int.parse(productprice)) as int;
                         String productimage = widget.productdetails.productimage;
                         bool addedtocart =  await addtocart(productname,productdescription,price,productvariation,quantity,productid,userid,ownerid,ownername,productimage);
                         if(addedtocart){
                          print('Added');
                         }
                          // ref.read(cartbuttontextprovider.notifier).state = 'Proceed to Checkout';
                        }, 
                        child: Text(buttontext)
                        ),
                    ],
                  ),
                )
            
          
          
          
                
                 
          
          
            ],
          ),
        ));
        
  }
  
 Future<bool> addtocart(String productName, String productDescription, int price, String productVariation, int quantity, String productId, String userId, String ownerId, String ownerName,String productimage) async {
  bool isAdded = false;
  final cartRef = FirebaseFirestore.instance.collection('cart').doc(userId).collection('Items').doc(productId);

  try {
    final docSnapshot = await cartRef.get();

    if (docSnapshot.exists) {
      final existingCart = Cart.fromMap(docSnapshot.data()!);
      int newQuantity = existingCart.Quantity + quantity;
      int newPrice = (price*newQuantity) as int;
      await cartRef.update({'Quantity': newQuantity});
      await cartRef.update({'productprice': newPrice});
    } else {
      final cart = Cart(
        productname: productName,
        productdescription: productDescription,
        productprice: price,
        productvariations: productVariation,
        Quantity: quantity,
        userId: userId,
        ProductId: productId, 
        ownerid: ownerId,
        ownername:ownerName, 
        productimage: productimage,
        
        
      );

      await cartRef.set(cart.toMap());
    }

    isAdded = true;
  } catch (e) {
    throw Exception('Exception: $e');
  }

  return isAdded;
}

  
}
