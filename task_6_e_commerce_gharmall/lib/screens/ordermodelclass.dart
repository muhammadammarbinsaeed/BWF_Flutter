// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class order {
  final String userid;
  final Map<String,dynamic> address;
  final Map<String,dynamic> cartitems;
 final int price;
 final String createdAt;
 final String Status;
  order({
    required this.userid,
    required this.address,
    required this.cartitems,
    required this.price,
    required this.createdAt,
    required this.Status,
  });

  order copyWith({
    String? userid,
    Map<String,dynamic>? address,
    Map<String,dynamic>? cartitems,
    int? price,
    String? createdAt,
    String? Status,
  }) {
    return order(
      userid: userid ?? this.userid,
      address: address ?? this.address,
      cartitems: cartitems ?? this.cartitems,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      Status: Status ?? this.Status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'address': address,
      'cartitems': cartitems,
      'price': price,
      'createdAt': createdAt,
      'Status': Status,
    };
  }

  factory order.fromMap(Map<String, dynamic> map) {
    return order(
      userid: map['userid'] as String,
      address: Map<String,dynamic>.from((map['address'] as Map<String,dynamic>),),
      cartitems: Map<String,dynamic>.from((map['cartItems'] as Map<String,dynamic>),),
      price: map['price'] as int,
      createdAt: map['createdAt'] as String,
      Status: map['Status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory order.fromJson(String source) => order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'order(userid: $userid, address: $address, cartitems: $cartitems, price: $price, createdAt: $createdAt, Status: $Status)';
  }

  @override
  bool operator ==(covariant order other) {
    if (identical(this, other)) return true;
  
    return 
      other.userid == userid &&
      mapEquals(other.address, address) &&
      mapEquals(other.cartitems, cartitems) &&
      other.price == price &&
      other.createdAt == createdAt &&
      other.Status == Status;
  }

  @override
  int get hashCode {
    return userid.hashCode ^
      address.hashCode ^
      cartitems.hashCode ^
      price.hashCode ^
      createdAt.hashCode ^
      Status.hashCode;
  }
}
