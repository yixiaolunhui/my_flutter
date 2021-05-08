import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/clock_view.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';

///绘制钟表
class ClockPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ClockPageState();
  }
}

class ClockPageState extends State<ClockPage> {
  //是否绘制边框
  bool isDrawBorder = false;

  //是否绘制刻度
  bool isDrawScale = false;

  //是否绘制数字
  bool isDrawNumber = false;

  //是否绘制移动小球
  bool isDrawMoveBall = false;

  //是否绘制时针
  bool isDrawHourHand = false;

  //是否绘制分针
  bool isDrawMinuteHand = false;

  //是否绘制秒针
  bool isDrawSecondHand = false;

  //是否绘制中间圆圈
  bool isDrawMiddleCircle = false;

  //是否移动
  bool isMove = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "钟表",
          onBack: () {
            Navigator.pop(context);
          }),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Center(
              child: ClockView(
                radius: 150,
                isDrawBorder: isDrawBorder,
                isDrawScale: isDrawScale,
                isDrawNumber: isDrawNumber,
                isDrawMoveBall: isDrawMoveBall,
                isDrawHourHand: isDrawHourHand,
                isDrawMinuteHand: isDrawMinuteHand,
                isDrawSecondHand: isDrawSecondHand,
                isDrawMiddleCircle: isDrawMiddleCircle,
                isMove: isMove,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.deepPurple,
              child: ListView(
                children: <Widget>[
                  SwitchListTile(
                    title: Text('是否绘制边框'),
                    value: isDrawBorder,
                    onChanged: (value) {
                      setState(() {
                        isDrawBorder = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('是否绘制刻度'),
                    value: isDrawScale,
                    onChanged: (value) {
                      setState(() {
                        isDrawScale = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('是否绘制数字'),
                    value: isDrawNumber,
                    onChanged: (value) {
                      setState(() {
                        isDrawNumber = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('是否绘制时针'),
                    value: isDrawHourHand,
                    onChanged: (value) {
                      setState(() {
                        isDrawHourHand = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('是否绘制分针'),
                    value: isDrawMinuteHand,
                    onChanged: (value) {
                      setState(() {
                        isDrawMinuteHand = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('是否绘制秒针'),
                    value: isDrawSecondHand,
                    onChanged: (value) {
                      setState(() {
                        isDrawSecondHand = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('是否绘制中间圆'),
                    value: isDrawMiddleCircle,
                    onChanged: (value) {
                      setState(() {
                        isDrawMiddleCircle = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('是否绘制移动小球'),
                    value: isDrawMoveBall,
                    onChanged: (value) {
                      setState(() {
                        isDrawMoveBall = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('是否移动'),
                    value: isMove,
                    onChanged: (value) {
                      setState(() {
                        isMove = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
