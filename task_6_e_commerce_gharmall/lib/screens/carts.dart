// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cart {
  final String productname;
  final String productdescription;
  final int productprice;
  final String productvariations;
  final int Quantity;
  final String userId;
  final String ProductId;
  final String ownerid;
  final String ownername;
  final String productimage;
  Cart({
    required this.productname,
    required this.productdescription,
    required this.productprice,
    required this.productvariations,
    required this.Quantity,
    required this.userId,
    required this.ProductId,
    required this.ownerid,
    required this.ownername,
    required this.productimage,
  });

  Cart copyWith({
    String? productname,
    String? productdescription,
    int? productprice,
    String? productvariations,
    int? Quantity,
    String? userId,
    String? ProductId,
    String? ownerid,
    String? ownername,
    String? productimage,
  }) {
    return Cart(
      productname: productname ?? this.productname,
      productdescription: productdescription ?? this.productdescription,
      productprice: productprice ?? this.productprice,
      productvariations: productvariations ?? this.productvariations,
      Quantity: Quantity ?? this.Quantity,
      userId: userId ?? this.userId,
      ProductId: ProductId ?? this.ProductId,
      ownerid: ownerid ?? this.ownerid,
      ownername: ownername ?? this.ownername,
      productimage: productimage ?? this.productimage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productname': productname,
      'productdescription': productdescription,
      'productprice': productprice,
      'productvariations': productvariations,
      'Quantity': Quantity,
      'userId': userId,
      'ProductId': ProductId,
      'ownerid': ownerid,
      'ownername': ownername,
      'productimage': productimage,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      productname: map['productname'] as String,
      productdescription: map['productdescription'] as String,
      productprice: map['productprice'] as int,
      productvariations: map['productvariations'] as String,
      Quantity: map['Quantity'] as int,
      userId: map['userId'] as String,
      ProductId: map['ProductId'] as String,
      ownerid: map['ownerid'] as String,
      ownername: map['ownername'] as String,
      productimage: map['productimage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(productname: $productname, productdescription: $productdescription, productprice: $productprice, productvariations: $productvariations, Quantity: $Quantity, userId: $userId, ProductId: $ProductId, ownerid: $ownerid, ownername: $ownername, productimage: $productimage)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;
  
    return 
      other.productname == productname &&
      other.productdescription == productdescription &&
      other.productprice == productprice &&
      other.productvariations == productvariations &&
      other.Quantity == Quantity &&
      other.userId == userId &&
      other.ProductId == ProductId &&
      other.ownerid == ownerid &&
      other.ownername == ownername &&
      other.productimage == productimage;
  }

  @override
  int get hashCode {
    return productname.hashCode ^
      productdescription.hashCode ^
      productprice.hashCode ^
      productvariations.hashCode ^
      Quantity.hashCode ^
      userId.hashCode ^
      ProductId.hashCode ^
      ownerid.hashCode ^
      ownername.hashCode ^
      productimage.hashCode;
  }
}
