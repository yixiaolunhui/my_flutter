import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';
import 'package:my_flutter/widgets/ruler_view.dart';

///尺子
class RulerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RulerState();
  }
}

class RulerState extends State<RulerPage> {
  int number = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "尺子",
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${number ?? ""}",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 30),
            RulerView(
              width: MediaQuery.of(context).size.width.ceil(),
              height: 60,
              value: number,
              minValue: 10,
              maxValue: 60,
              step: 2,
              subScaleWidth: 10,
              subScaleCountPerScale: 5,
              scaleColor: Colors.black,
              scaleWidth: 2,
              scaleTextColor: Colors.black,
              scaleTextWidth: 15,
              onSelectedChanged: (result) {
                setState(() {
                  number = result;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
