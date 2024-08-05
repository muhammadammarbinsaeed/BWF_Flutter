// ignore_for_file: unused_local_variable, unused_result, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_gharmall/providers.dart';
import 'package:task_6_e_commerce_gharmall/screens/addressmodel.dart';
import 'package:task_6_e_commerce_gharmall/screens/carts.dart';
class Cartdata extends ConsumerStatefulWidget {
  const Cartdata({super.key});

  @override
  ConsumerState<Cartdata> createState() => _CartdataState();
}

class _CartdataState extends ConsumerState<Cartdata> {
  TextEditingController streetcontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController zipcodecontroller = TextEditingController();

  User? currentuser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () => updateTotal(ref));
  }
   void updateTotal(WidgetRef ref) {
    final carts =  ref.watch(fetchcarts);
     int newTotal = 0;
    if (carts.asData?.value != null) {
      carts.when(data: (Data){
        for( var cart in Data!)
        {
              newTotal += cart.productprice;
        }

      }, error:  (e, st) => Center(child: Text('Error: ${e.toString()}')), 
      loading: () => Center(child: CircularProgressIndicator()));
      ref.read(cartprice.notifier).state = newTotal;
    }
  }
  @override
  Widget build(BuildContext context) {
    final totalprice = ref.watch(cartprice);
   // print(totalprice);
    final cartsAsyncValue = ref.watch(fetchcarts);
    return Scaffold(
      appBar: AppBar(
        title: Text('Carts'),
        centerTitle: true,
      ),
      body: cartsAsyncValue.when(
          data: (carts) {
            if (carts!.isEmpty) {
              return Center(child: Text('No Product in Cart.'));
            }
            return Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 2.6),
                      ),
                      itemCount: carts.length,
                      itemBuilder: (context, index) {
                        final cart = carts[index];
                        return Card(color: Colors.grey.shade300,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Center(
                                      child: Image.network(
                                    cart.productimage,
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
                                  padding: const EdgeInsets.only(left: 10, top: 8),
                                  child: Center(
                                      child: Text(
                                    cart.productname,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ),
                               
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 3),
                                  child: Center(child: Text(cart.productdescription)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 3),
                                  child: Center(child: Text(cart.productvariations)),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 3),
                                  child: Center(child: Text('Quantity: ' + cart.Quantity.toString())),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, top: 3),
                                      child: Center(child: Text('Price: ' + cart.productprice.toString())),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10, top: 3),
                                      child: GestureDetector(
                                        onTap: ()async{
                                          bool isdeleted = await deletefromcart(cart.ProductId);
                                          if(isdeleted){
                                             ref.invalidate(fetchcarts);
                                             final deletedproductprice = cart.productprice;
                                            ref.read(cartprice.notifier).state = totalprice - deletedproductprice;
                                          }
                                        },
                                        child: Center(child:Icon(Icons.delete))
                                        ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Price:',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    Text('$totalprice',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),  
              
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                             foregroundColor: WidgetStateProperty.all(
                                Colors.white,
                             ),
                            backgroundColor: WidgetStateProperty.all(
                              Color.fromARGB(255,98, 107, 252),
                            ),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)
                                   )
                            )
                  
                          ),
                onPressed: ()async{
                  
                  final address = await showDialog(
                    context: context, 
                    builder:(context)=>AlertDialog(
                      title: Text('Enter Address'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              controller: streetcontroller,
                              decoration: InputDecoration(labelText: 'Street'),
                            ),
                            TextField(
                              controller: citycontroller,
                              decoration: InputDecoration(labelText: 'City'),
                            ),
                            TextField(
                              controller: statecontroller,
                              decoration: InputDecoration(labelText: 'State'),
                            ),
                            TextField(
                              controller: zipcodecontroller,
                              decoration: InputDecoration(labelText: 'zipcode'),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: (){
                           Navigator.pop(context);
                        }, child: Text('Cancel')),
                        TextButton(
            onPressed: (){
            
              final address = Addressmodel(street: streetcontroller.text.trim(), city: citycontroller.text.trim(), state: statecontroller.text.trim(), zipcode: zipcodecontroller.text.trim());
              Navigator.pop(context, address);
            }
        ,
            child: Text('Confirm'),
          ),
                      ],

                    )
                  );
                  if (address != null) {
                    await saveAddress(address);
                  bool iscreated =  await createOrder(address, carts,totalprice);
                  await clearCart();
                  if(iscreated){
                    ref.invalidate(fetchcarts);
                  }
                  
    }
              
              }, child: Text('Proceed to Checkout!'))
                ],
              ),
            );
          },
          error: (e, st) => Center(child: Text('Error: ${e.toString()}')),
          loading: () => Center(child: CircularProgressIndicator())),
    );
  }
  
  Future<bool> deletefromcart(String productId) async{
    bool isdeleted = false;
     try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(currentuser!.uid)
          .collection('Items')
          .doc(productId)
          .delete().then((value){
          isdeleted = true;
          });
         
    } catch (e) {
      // Handle error
    }
    return isdeleted;
  }

  Future<bool> createOrder(Addressmodel address, List<Cart> carts,int totalprice) async {
    bool iscreated = false;
    try {
      final orderRef = FirebaseFirestore.instance.collection('orders').doc();
  final orderData = {
    'userId': currentuser!.uid, // Assuming you have user data
    'address': address.toMap(),
    'cartItems': carts.map((cart) => cart.toMap()).toList(),
    'price': totalprice,
    'createdAt': DateTime.now(),
    'Status': 'Pending',
    // Add other relevant order details here
  };

  await orderRef.set(orderData);
  iscreated = true;
    } catch (e) {
      
    }
    return iscreated;
  
}
  
 Future<void> clearCart() async {
  final cartRef = FirebaseFirestore.instance.collection('cart').doc(currentuser!.uid).collection('Items');
  await cartRef.get().then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  });
}

 Future<void> saveAddress(Addressmodel address) async {
  final user = FirebaseAuth.instance.currentUser!; 
  final addressesRef = FirebaseFirestore.instance.collection('addresses').doc(user.uid);

  try {
    final docSnapshot = await addressesRef.get();
    if (docSnapshot.exists) {
      
      await addressesRef.update({'address': address.toMap()});
    } else {
      await addressesRef.set({
        'address': address.toMap(),
      });
    }
  } catch (e) {
    // Handle error
  }
}
}