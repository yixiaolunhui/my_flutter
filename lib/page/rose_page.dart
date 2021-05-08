import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';
import 'package:my_flutter/widgets/other/rose/rose.dart';

///玫瑰花
class RosePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RoseState();
  }
}

class RoseState extends State<RosePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "玫瑰花",
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: RoseView(),
      ),
    );
  }
}
