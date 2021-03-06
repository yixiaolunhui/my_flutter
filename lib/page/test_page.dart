import 'package:flutter/material.dart';

class TranslucentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TranslucentState();
  }
}

class TranslucentState extends State<TranslucentPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 250,
          height: 400,
          color: Colors.blue,
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.bottomCenter,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    imageCache.clear();
                  });
                },
                child: Text(
                  '我是设置透明度的Widget',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 36.0,
                      decoration: TextDecoration.none),
                ),
              ),
            ],
          )),
    );
  }
}
