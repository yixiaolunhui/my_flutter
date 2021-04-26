import 'package:flutter/material.dart';
import 'package:my_flutter/app/route_helper.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';

///主页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Flutter学习",
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              color: Colors.blue,
              height: 100,
              child: Text(
                "悬浮按钮",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteHelper.floatPage);
              },
            ),
            SizedBox(height: 50),
            MaterialButton(
              color: Colors.blue,
              height: 100,
              child: Text(
                "钟表",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteHelper.clockPage);
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
