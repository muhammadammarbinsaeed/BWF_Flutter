// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Addressmodel {

  final String street;
  final String city;
  final String state;
  final String zipcode;
  Addressmodel({
    required this.street,
    required this.city,
    required this.state,
    required this.zipcode,
  });

  Addressmodel copyWith({
    String? street,
    String? city,
    String? state,
    String? zipcode,
  }) {
    return Addressmodel(
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipcode: zipcode ?? this.zipcode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street,
      'city': city,
      'state': state,
      'zipcode': zipcode,
    };
  }

  factory Addressmodel.fromMap(Map<String, dynamic> map) {
    return Addressmodel(
      street: map['street'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      zipcode: map['zipcode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Addressmodel.fromJson(String source) => Addressmodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Addressmodel(street: $street, city: $city, state: $state, zipcode: $zipcode)';
  }

  @override
  bool operator ==(covariant Addressmodel other) {
    if (identical(this, other)) return true;
  
    return 
      other.street == street &&
      other.city == city &&
      other.state == state &&
      other.zipcode == zipcode;
  }

  @override
  int get hashCode {
    return street.hashCode ^
      city.hashCode ^
      state.hashCode ^
      zipcode.hashCode;
  }
}
