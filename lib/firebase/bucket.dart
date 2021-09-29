import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendo/commonComponents/snackme.dart';
import 'package:vendo/models/model_user.dart';
import 'dart:math';

import 'package:vendo/utils/random_util.dart';

FirebaseStorage _storage = FirebaseStorage.instance;

void init(){

}

Future<String?> uploadToBucket() async {
  print("Starting upload");
  ImagePicker imagePicker = new ImagePicker();
  XFile? image;
  image = await imagePicker.pickImage(source: ImageSource.gallery);

  String random = getRandomString(15);
  Reference reference =
        _storage.ref().child("img/$random");

  if(image==null) return Future.error("Error null image..");
  File file = File(image.path);

  UploadTask uploadTask = reference.putFile(file);

  TaskSnapshot taskSnapshot = await uploadTask;
  String url = await taskSnapshot.ref.getDownloadURL();

  return url;
}

Future<String?> uploadToBucketTest() async {
  print("Starting upload");
  ImagePicker imagePicker = new ImagePicker();
  XFile? image;
  image = await imagePicker.pickImage(source: ImageSource.gallery);

  Reference reference =
        _storage.ref().child("img/123");

  if(image==null) return Future.error("Error null image..");
  File file = File(image.path);

  UploadTask uploadTask = reference.putFile(file);

  TaskSnapshot taskSnapshot = await uploadTask;
  String url = await taskSnapshot.ref.getDownloadURL();

  return url;
}