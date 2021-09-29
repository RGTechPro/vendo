import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendo/commonComponents/snackme.dart';
import 'package:vendo/models/model_user.dart';

FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

void init(){
  firestoreInstance = FirebaseFirestore.instance;
}

Future<DocumentReference> addSampleData(){
  CollectionReference users = FirebaseFirestore.instance.collection('sellers');

  return users
    .add({
      'full_name': "Yes", // John Doe
      'company': "OK", // Stokes and Sons
      'age': "MF" // 42
    });
}

Future<DocumentReference> addSellerRecord(Seller sellerRecord){
  CollectionReference sellerRec = FirebaseFirestore.instance.collection('sellers');
  return sellerRec.add(sellerRecord.toMap());
}