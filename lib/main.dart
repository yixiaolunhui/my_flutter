import 'package:flutter/material.dart';
import 'package:my_flutter/app/app.dart';
import 'package:my_flutter/app/route_helper.dart';
import 'package:my_flutter/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: App.navigatorKey,
      theme: ThemeData(
        canvasColor: Color(0xffF5F6F9),
      ),
      routes: RouteHelper.routes,
      home: HomePage(),
    );
  }
}
