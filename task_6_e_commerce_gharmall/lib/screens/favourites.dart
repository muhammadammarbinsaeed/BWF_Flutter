import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first


class Favourites {
  final String productname;
  final String productdescription;
  final String productprice;
  final List productvariations;
  final String userId;
  final String ProductId;
  final String productImage;
  final String ownername;
  Favourites({
    required this.productname,
    required this.productdescription,
    required this.productprice,
    required this.productvariations,
    required this.userId,
    required this.ProductId,
    required this.productImage,
    required this.ownername,
  });
 

  Favourites copyWith({
    String? productname,
    String? productdescription,
    String? productprice,
    List? productvariations,
    String? userId,
    String? ProductId,
    String? productImage,
    String? ownername,
  }) {
    return Favourites(
      productname: productname ?? this.productname,
      productdescription: productdescription ?? this.productdescription,
      productprice: productprice ?? this.productprice,
      productvariations: productvariations ?? this.productvariations,
      userId: userId ?? this.userId,
      ProductId: ProductId ?? this.ProductId,
      productImage: productImage ?? this.productImage,
      ownername: ownername ?? this.ownername,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productname': productname,
      'productdescription': productdescription,
      'productprice': productprice,
      'productvariations': productvariations,
      'userId': userId,
      'ProductId': ProductId,
      'productImage': productImage,
      'ownername': ownername,
    };
  }

  factory Favourites.fromMap(Map<String, dynamic> map) {
    return Favourites(
      productname: map['productname'] as String,
      productdescription: map['productdescription'] as String,
      productprice: map['productprice'] as String,
      productvariations: List.from((map['productvariations'] as List)),
      userId: map['userId'] as String,
      ProductId: map['ProductId'] as String,
      productImage: map['productImage'] as String,
      ownername: map['ownername'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favourites.fromJson(String source) => Favourites.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Favourites(productname: $productname, productdescription: $productdescription, productprice: $productprice, productvariations: $productvariations, userId: $userId, ProductId: $ProductId, productImage: $productImage, ownername: $ownername)';
  }

  @override
  bool operator ==(covariant Favourites other) {
    if (identical(this, other)) return true;
  
    return 
      other.productname == productname &&
      other.productdescription == productdescription &&
      other.productprice == productprice &&
      listEquals(other.productvariations, productvariations) &&
      other.userId == userId &&
      other.ProductId == ProductId &&
      other.productImage == productImage &&
      other.ownername == ownername;
  }

  @override
  int get hashCode {
    return productname.hashCode ^
      productdescription.hashCode ^
      productprice.hashCode ^
      productvariations.hashCode ^
      userId.hashCode ^
      ProductId.hashCode ^
      productImage.hashCode ^
      ownername.hashCode;
  }
}
