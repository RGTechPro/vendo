import 'package:flutter/cupertino.dart';

class User{

  ///if we are using the const constructor then we need to have only final value variable
  final String name;
  final String profileImageUrl;

  //It creates compile time constants i.e., compile time constant values
    const User({
    required this.name,
    required this.profileImageUrl
  }); // it will take some named arguments

}


