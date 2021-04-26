import 'package:flutter/material.dart';
import 'package:my_flutter/app/typedef/function.dart';

///AppBar
AppBar customAppBar({String title, ParamVoidCallback onBack}) {
  return AppBar(
    brightness: Brightness.light,
    title: Text(
      title,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    leading: onBack == null
        ? new Container()
        : new IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              onBack();
            }),
  );
}
