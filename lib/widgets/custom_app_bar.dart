import 'package:flutter/material.dart';
import 'package:my_flutter/app/typedef/function.dart';

///自定义AppBar
class CustomAppBar extends AppBar {
  CustomAppBar({
    String title,
    ParamVoidCallback onBack,
  }) : super(
          brightness: Brightness.light,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          // bottom: PreferredSize(
          //   child: Container(
          //     color: Colors.red,
          //     width: double.infinity,
          //     height: 3,
          //   ),
          // ),
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
