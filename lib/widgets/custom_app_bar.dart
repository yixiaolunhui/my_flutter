import 'package:flutter/material.dart';
import 'package:my_flutter/app/typedef/function.dart';

///自定义AppBar
class CustomAppBar extends AppBar {
  CustomAppBar({
    String title,
    ParamVoidCallback onBack,
    List<Widget> actions,
  }) : super(
          brightness: Brightness.light,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: actions,
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: onBack == null
              ? new Container()
              : new IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    onBack();
                  },
                ),
        );
}
