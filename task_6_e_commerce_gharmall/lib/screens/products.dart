// ignore_for_file: unused_local_variable, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Product {
  final String name;
  final String description;
  final String price;
  final String category;
  final List variations;
  String productimage;
  final String productID;
  final String userId;
  final String ownername;
  // Add other product fields as needed

  Product({
    required this.variations,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.productimage,
    required this.productID,
    required this.userId,
    required this.ownername,
  });

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    // final storageRef = FirebaseStorage.instance.ref(); // Get a reference to Firebase Storage
    // final imageRef = storageRef.child(snapshot['productimage']);
    // final imageUrl = getImageUrl(imageRef);
    return Product(
      name: snapshot['productname'] as String,
      description: snapshot['productdescription'] as String,
      price: snapshot['productprice'] as String,
      category: snapshot['productcategory'] as String,
      variations: snapshot['productvariations'] as List,
      productimage:  snapshot['productimage'] as String,
      productID: snapshot['productid'] as String,
      userId: snapshot['userID'] as String,
      ownername: snapshot['ownername'] as String,
      
      
 
      // Access other product fields from snapshot data
    );
  }



}
//   Future<String> getImageUrl(imageRef) async {
//   try {
//     final url = await imageRef.getDownloadURL();
//     return url;
//   } catch (error) {
//     print('Error fetching image URL: $error');
//     // Implement error handling (e.g., return a default URL or display an error message)
//     return 'https://via.placeholder.com/150'; // Example placeholder URL
//   }
// }