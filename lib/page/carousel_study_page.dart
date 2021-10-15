import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/utils/image_utils.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';
import 'package:my_flutter/widgets/flutter_carousel.dart';

///旋转木马学习页
class CarouselStudyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CarouselStudyState();
}

class CarouselStudyState extends State<CarouselStudyPage> {
  final double startAngle = 0;
  final double slipRatio = 0.5;
  final double childWidth = 100;
  final double childHeight = 100;
  int count = 1;
  double rotateAngle = 0;
  double downX = 0.0;
  double downAngle = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "旋转木马学习页",
          onBack: () {
            Navigator.pop(context);
          }),
      body: Column(
        children: [
          ///圆形布局
          _circleWidget(context),

          ///操作按钮
          _actionBtnsWidget(),
        ],
      ),
    );
  }

  ///角度转弧度
  ///弧度 =度数 * (π / 180）
  ///度数 =弧度 * (180 / π）
  double radian(double angle) {
    return angle * pi / 180;
  }

  ///子控件集
  List<Point> _childPointList({Size size = Size.zero}) {
    List<Point> childPointList = [];
    double averageAngle = 360 / count;
    double radius = size.width / 2 - childWidth / 2;
    for (int i = 0; i < count; i++) {
      //+rotateAngle：逆时针  -rotateAngle：顺时针
      double angle = startAngle + averageAngle * i - rotateAngle;
      var centerX = size.width / 2 + sin(radian(angle)) * radius;
      var centerY = size.height / 2 + cos(radian(angle)) * radius;
      childPointList.add(Point(
        centerX,
        centerY,
        childWidth,
        childHeight,
        centerX - childWidth / 2,
        centerY - childHeight / 2,
        centerX + childWidth / 2,
        centerY + childHeight / 2,
        1,
        angle,
        i,
      ));
    }
    return childPointList;
  }

  ///圆形布局
  _circleWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return GestureDetector(
            ///水平滑动开始
            onHorizontalDragStart: (DragStartDetails details) {
              //记录拖动开始时当前的选择角度值
              downAngle = rotateAngle;
              //记录拖动开始时的x坐标
              downX = details.globalPosition.dx;
            },

            ///水平滑动中
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              //滑动中X坐标值
              var updateX = details.globalPosition.dx;
              //计算当前旋转角度值并刷新
              rotateAngle = (downX - updateX) * slipRatio + downAngle;
              if (mounted) setState(() {});
            },
            behavior: HitTestBehavior.opaque,
            child: Stack(
              children: _childPointList(size: constraints.biggest).map(
                (Point point) {
                  return Positioned(
                    width: point.width,
                    left: point.left,
                    top: point.top,
                    child: Image(
                      image: ImageUtils.getAssetImage("hongbao"),
                      filterQuality: FilterQuality.high,
                    ),
                  );
                },
              ).toList(),
            ),
          );
        },
      ),
    );
  }

  ///操作按钮
  _actionBtnsWidget() {
    return Column(
      children: [
        CupertinoButton(
          child: Text("添加"),
          color: Colors.blue,
          onPressed: () {
            count++;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        SizedBox(height: 10),
        CupertinoButton(
          child: Text("清空"),
          color: Colors.blue,
          onPressed: () {
            count = 0;
            rotateAngle = 0;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        SizedBox(height: 10),
        CupertinoButton(
          child: Text("角度"),
          color: Colors.blue,
          onPressed: () {
            rotateAngle += 2;
            if (mounted) {
              setState(() {});
            }
          },
        ),
      ],
    );
  }
}
