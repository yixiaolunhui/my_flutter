import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';

///Canvas
///- canvas.save();    画布将当前的状态保存
///- canvas.restore(); 画布取出原来所保存的状态
class CanvasPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CanvasPageState();
}

class CanvasPageState extends State<CanvasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Canvas",
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: CustomPaint(
          painter: BackgroundCustomPainter(),
          foregroundPainter: CanvasPainter(),
          size: Size(200, 200),
        ),
      ),
    );
  }
}

class BackgroundCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;
    Rect rect = new Rect.fromLTRB(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this == oldDelegate;
  }
}

class CanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // test(canvas);
    drawNumberTest(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this == oldDelegate;
  }
}

//绘制数字坐标系演示
void drawNumberTest(Canvas canvas) {
  double angle = degToRad(360 / 60);
  drawXY(canvas);
  canvas.translate(100, 100);
  for (var i = 0; i < 3; i++) {
    canvas.save();
    canvas.translate(0.0, -70);
    drawXY(canvas);
    canvas.rotate(-angle * i * 5);
    drawXY(canvas);
    canvas.restore();
    canvas.rotate(angle * 5);
  }
}

void test(Canvas canvas) {
  //第1个
  canvas.drawRect(
      Rect.fromLTRB(0, 0, 50, 50),
      Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill
        ..strokeWidth = 10);

  canvas.save();

  drawXY(canvas);
  //旋转45
  canvas.rotate(degToRad(45));
  drawXY(canvas);

  //第2个
  canvas.drawRect(
      Rect.fromLTRB(100, 0, 150, 50),
      Paint()
        ..color = Colors.yellow
        ..style = PaintingStyle.fill
        ..strokeWidth = 10);

  canvas.restore();

  //第3个
  canvas.drawRect(
      Rect.fromLTRB(0, 150, 50, 200),
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill
        ..strokeWidth = 10);
}

///绘制坐标系 X轴  Y轴
void drawXY(Canvas canvas) {
  //X轴
  canvas.drawLine(
      Offset(0, 0),
      Offset(150, 0),
      Paint()
        ..color = Colors.green
        ..strokeWidth = 4);

  //Y轴
  canvas.drawLine(
      Offset(0, 0),
      Offset(0, 150),
      Paint()
        ..color = Colors.red
        ..strokeWidth = 4);
}

//角度转换为弧度
num degToRad(num deg) => deg * (pi / 180.0);
