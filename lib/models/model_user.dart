import 'package:cloud_firestore/cloud_firestore.dart';

class Seller {
  final String sellerName;
  final String email;
  final String name;
  final String phoneNumber;
  final String profilePictureUrl;
  final Timestamp creationDate;

  const Seller(
    this.sellerName,
    this.email,
    this.name,
    this.phoneNumber,
    this.profilePictureUrl,
    this.creationDate
  );

  Map<String, dynamic> toMap() {
    return {
      'sellerName': sellerName,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'profilePictureUrl': profilePictureUrl,
      'creationDate': creationDate,
    };
  }

  factory Seller.fromDocument(DocumentSnapshot document) {
    return Seller(
      document['sellerName'],
      document['email'],
      document['name'],
      document['phoneNumber'],
      document['profilePictureUrl'],
      document['creationDate']
    );
  }
}
