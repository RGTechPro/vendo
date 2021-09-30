import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showSnack(BuildContext context, String text){
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
}