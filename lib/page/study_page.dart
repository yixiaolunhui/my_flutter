import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/app/route_helper.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';


///学习页面
class StudyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StudyPageState();
}

class StudyPageState extends State<StudyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "学习",
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              color: Colors.blue,
              height: 50,
              child: Text(
                "Canvas",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteHelper.canvasPage);
              },
            ),
            SizedBox(height: 50),

          ],
        ),
      ),
    );
  }
}
