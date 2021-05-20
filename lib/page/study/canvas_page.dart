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

//绘制背景
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
    return false;
  }
}

class CanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    saveAndRestore(canvas);
    // drawNumberTest(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this == oldDelegate;
  }
}



///canvas.save() / canvas.restore();
void saveAndRestore(Canvas canvas) {

  //第1个方框
  canvas.drawRect(
      Rect.fromLTRB(0, 0, 50, 50),
      Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill
        ..strokeWidth = 10);

  drawXY(canvas);
  canvas.save();
  canvas.rotate(degToRad(45)); //旋转45

  //第2个方框
  canvas.drawRect(
      Rect.fromLTRB(100, 0, 150, 50),
      Paint()
        ..color = Colors.yellow
        ..style = PaintingStyle.fill
        ..strokeWidth = 10);

  canvas.restore();
  drawXY(canvas);
  //第3个方框
  canvas.drawRect(
      Rect.fromLTRB(0, 150, 50, 200),
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill
        ..strokeWidth = 10);



}





///绘制数字坐标系演示
void drawNumberTest(Canvas canvas) {
  double angle = degToRad(360 / 60);
  drawXY(canvas);
  canvas.translate(100, 100);
  drawXY(canvas);
  for (var i = 0; i < 3; i++) {
    canvas.save();
    canvas.translate(0.0, -70);
    drawXY(canvas);
    // canvas.rotate(-angle * i * 5);
    drawText(canvas,"${i+1}");
    drawXY(canvas);
    canvas.restore();
    canvas.rotate(angle * 5);
  }
}


///绘制文字
void drawText(Canvas canvas, String num) {
  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
  );

  textPainter.text = TextSpan(
    text: "$num",
    style: TextStyle(color: Colors.white, fontSize: 25),
  );

  textPainter.layout();
  textPainter.paint(
    canvas,
    Offset(
      -(textPainter.width / 2),
      -(textPainter.height / 2),
    ),
  );
}






///绘制坐标系 X轴  Y轴
void drawXY(Canvas canvas) {
  //X轴
  canvas.drawLine(
      Offset(0, 0),
      Offset(250, 0),
      Paint()
        ..color = Colors.green
        ..strokeWidth = 2);

  //Y轴
  canvas.drawLine(
      Offset(0, 0),
      Offset(0, 250),
      Paint()
        ..color = Colors.red
        ..strokeWidth = 2);
}

//角度转换为弧度
num degToRad(num deg) => deg * (pi / 180.0);
