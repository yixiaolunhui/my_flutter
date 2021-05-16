import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

///时钟
class ClockView extends StatefulWidget {
  const ClockView({
    Key key,
    this.radius = 150,
    this.borderColor = Colors.black,
    this.scaleColor = Colors.black,
    this.numberColor = Colors.black,
    this.moveBallColor = Colors.red,
    this.hourHandColor = Colors.black,
    this.minuteHandColor = Colors.black,
    this.secondHandColor = Colors.red,
    this.middleCircleColor = Colors.red,
    this.isDrawBorder = true,
    this.isDrawScale = true,
    this.isDrawNumber = true,
    this.isDrawMoveBall = true,
    this.isDrawHourHand = true,
    this.isDrawMinuteHand = true,
    this.isDrawSecondHand = true,
    this.isDrawMiddleCircle = true,
    this.isMove = true,
  }) : super(key: key);

  //钟表的半径
  final double radius;

  //边框的颜色
  final Color borderColor;

  //刻度的颜色
  final Color scaleColor;

  //数字的颜色
  final Color numberColor;

  //走秒小球颜色
  final Color moveBallColor;

  //时针的颜色
  final Color hourHandColor;

  //分针的颜色
  final Color minuteHandColor;

  //秒针的颜色
  final Color secondHandColor;

  //中间圆颜色
  final Color middleCircleColor;

  //是否绘制边框
  final bool isDrawBorder;

  //是否绘制刻度
  final bool isDrawScale;

  //是否绘制数字
  final bool isDrawNumber;

  //是否绘制移动小球
  final bool isDrawMoveBall;

  //是否绘制时针
  final bool isDrawHourHand;

  //是否绘制分针
  final bool isDrawMinuteHand;

  //是否绘制秒针
  final bool isDrawSecondHand;

  //是否绘制中间圆圈
  final bool isDrawMiddleCircle;

  //是否走起来
  final bool isMove;

  @override
  State<StatefulWidget> createState() {
    return ClockViewState();
  }
}

class ClockViewState extends State<ClockView> {
  //当前时间
  DateTime dateTime;

  //定时器
  Timer timer;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (widget.isMove) {
        setState(() {
          dateTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    //取消定时器
    if (timer.isActive) {
      timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClockPainter(
        dateTime,
        radius: widget.radius,
        borderColor: this.widget.borderColor,
        scaleColor: this.widget.scaleColor,
        numberColor: this.widget.numberColor,
        moveBallColor: this.widget.moveBallColor,
        hourHandColor: this.widget.hourHandColor,
        minuteHandColor: this.widget.minuteHandColor,
        secondHandColor: this.widget.secondHandColor,
        middleCircleColor: this.widget.middleCircleColor,
        isDrawBorder: this.widget.isDrawBorder,
        isDrawScale: this.widget.isDrawScale,
        isDrawNumber: this.widget.isDrawNumber,
        isDrawMoveBall: this.widget.isDrawMoveBall,
        isDrawHourHand: this.widget.isDrawHourHand,
        isDrawMinuteHand: this.widget.isDrawMinuteHand,
        isDrawSecondHand: this.widget.isDrawSecondHand,
        isDrawMiddleCircle: this.widget.isDrawMiddleCircle,
        isMove: this.widget.isMove,
      ),
      size: Size(widget.radius * 2, widget.radius * 2),
    );
  }
}

class ClockPainter extends CustomPainter {
  //边框的颜色
  final Color borderColor;

  //刻度的颜色
  final Color scaleColor;

  //数字的颜色
  final Color numberColor;

  //中间圆颜色
  final Color middleCircleColor;

  //走秒小球颜色
  final Color moveBallColor;

  //时针的颜色
  final Color hourHandColor;

  //分针的颜色
  final Color minuteHandColor;

  //秒针的颜色
  final Color secondHandColor;

  //是否绘制边框
  final bool isDrawBorder;

  //是否绘制刻度
  final bool isDrawScale;

  //是否绘制数字
  final bool isDrawNumber;

  //是否绘制移动小球
  final bool isDrawMoveBall;

  //是否绘制时针
  final bool isDrawHourHand;

  //是否绘制分针
  final bool isDrawMinuteHand;

  //是否绘制秒针
  final bool isDrawSecondHand;

  //是否绘制中间圆圈
  final bool isDrawMiddleCircle;

  //是否走起来
  final bool isMove;

  //边框画笔的宽度
  double borderWidth;

  //刻度画笔的宽度
  double scaleWidth;

  //数字画笔的宽度
  double numberWidth;

  //时针画笔的宽度
  double hourHandWidth;

  //分针画笔的宽度
  double minuteHandWidth;

  //秒针画笔的宽度
  double secondHandWidth;

  //中间圆的宽度
  double middleCircleWidth;

  //小刻度的位置集合
  List<Offset> scaleOffset = [];

  //大刻度的位置集合 每5个小刻度是一个大刻度
  List<Offset> bigScaleOffset = [];

  //钟表的半径
  final double radius;

  //当前时间
  final DateTime dateTime;

  //边框画笔
  Paint borderPaint;

  //刻度画笔
  Paint scalePaint;

  //数字画笔
  TextPainter textPainter;

  //时针画笔
  Paint hourPaint;

  //分针画笔
  Paint minutePaint;

  //秒针画笔
  Paint secondPaint;

  //中间圆画笔
  Paint centerPaint;

  //移动小球画笔
  Paint moveBallPaint;

  double angle;

  ClockPainter(
    this.dateTime, {
    this.radius,
    this.borderColor,
    this.scaleColor,
    this.numberColor,
    this.moveBallColor,
    this.hourHandColor,
    this.minuteHandColor,
    this.secondHandColor,
    this.middleCircleColor,
    this.isDrawBorder,
    this.isDrawScale,
    this.isDrawNumber,
    this.isDrawMoveBall,
    this.isDrawHourHand,
    this.isDrawMinuteHand,
    this.isDrawSecondHand,
    this.isDrawMiddleCircle,
    this.isMove,
  }) {
    //根据自己的审美设置这些画笔的宽度
    borderWidth = 8 * (radius / 100);
    scaleWidth = 2 * (radius / 100);
    numberWidth = 20 * (radius / 100);
    hourHandWidth = 5 * (radius / 100);
    minuteHandWidth = 3 * (radius / 100);
    secondHandWidth = 1 * (radius / 100);
    middleCircleWidth = 4 * (radius / 100);

    //边框画笔
    borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    //刻度画笔
    scalePaint = Paint()
      ..color = numberColor
      ..strokeWidth = scaleWidth
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;

    //数字
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    //时针画笔
    hourPaint = Paint()
      ..color = hourHandColor
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = hourHandWidth;

    //分针画笔
    minutePaint = Paint()
      ..color = minuteHandColor
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = minuteHandWidth;

    //秒针画笔
    secondPaint = Paint()
      ..color = secondHandColor
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = secondHandWidth;

    //中间圆
    centerPaint = Paint()
      ..strokeWidth = middleCircleWidth
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..color = middleCircleColor;

    //移动小球画笔
    moveBallPaint = Paint()
      ..strokeWidth = scaleWidth * 2
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..color = moveBallColor;

    //计算出 小刻度和大刻度
    final distance = radius - borderWidth * 2;
    for (var i = 0; i < 60; i++) {
      Offset offset = Offset(
        radius + distance * sin(degToRad(360 / 60 * i)),
        radius - distance * cos(degToRad(360 / 60 * i)),
      );
      //小刻度
      scaleOffset.add(offset);
      //大刻度
      if (i % 5 == 0) {
        bigScaleOffset.add(offset);
      }
    }

    //每个刻度的弧度
    angle = degToRad(360 / 60);
  }

  @override
  void paint(Canvas canvas, Size size) {
    //绘制边框
    if (isDrawBorder) {
      drawBorder(canvas);
    }

    //绘制刻度
    if (isDrawScale) {
      drawScale(canvas);
    }

    //绘制数字
    if (isDrawNumber) {
      drawNumber(canvas);
    }

    //绘制时针
    if (isDrawHourHand) {
      drawHour(canvas);
    }

    //绘制分针
    if (isDrawMinuteHand) {
      drawMinute(canvas);
    }

    //绘制秒针
    if (isDrawSecondHand) {
      drawSecond(canvas);
    }

    //绘制中间圆圈
    if (isDrawMiddleCircle) {
      drawMiddleCircle(canvas);
    }

    //绘制移动小球
    if (isDrawMoveBall) {
      drawMoveBall(canvas);
    }
  }

  //判断是否需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  ///绘制边框
  void drawBorder(Canvas canvas) {
    canvas.drawCircle(
        Offset(radius, radius), radius - borderWidth / 2, borderPaint);
  }

  ///绘制刻度
  void drawScale(Canvas canvas) {
    //小刻度
    if (scaleOffset.length > 0) {
      canvas.drawPoints(PointMode.points, scaleOffset, scalePaint);
    }

    //大刻度
    final biggerScalePaint = Paint()
      ..strokeWidth = scaleWidth * 2
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..color = numberColor;
    canvas.drawPoints(PointMode.points, bigScaleOffset, biggerScalePaint);
  }

  ///绘制数字
  void drawNumber(Canvas canvas) {
    canvas.save();

    //移动的圆点（水平向右为正向，竖直向下为正向）
    canvas.translate(radius, radius);

    for (var i = 0; i < bigScaleOffset.length; i++) {
      canvas.save();
      //上移移动到待绘制的地方
      canvas.translate(0.0, -radius + borderWidth * 4);
      //旋转，确定数字竖直绘制
      canvas.rotate(-angle * i * 5);
      //设置文字及样式
      textPainter.text = TextSpan(
        text: "${i == 0 ? 12 : i}",
        style: TextStyle(color: numberColor, fontSize: numberWidth),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        new Offset(
          -(textPainter.width / 2),
          -(textPainter.height / 2),
        ),
      );
      canvas.restore();

      canvas.rotate(angle * 5);
    }

    canvas.restore();
  }

  ///绘制时针
  void drawHour(Canvas canvas) {
    final hour = dateTime.hour;
    double angle = 360 / 12 * hour;
    Offset hourHand1 = Offset(
      radius + (radius * 0.1) * sin(degToRad(angle + 180)),
      radius - (radius * 0.1) * cos(degToRad(angle + 180)),
    );
    Offset hourHand2 = Offset(
      radius + (radius * 0.45) * sin(degToRad(angle)),
      radius - (radius * 0.45) * cos(degToRad(angle)),
    );
    canvas.drawLine(hourHand1, hourHand2, hourPaint);
  }

  ///绘制分针
  void drawMinute(Canvas canvas) {
    final minute = dateTime.minute;
    double angle = 360 / 60 * minute;
    Offset minuteHand1 = Offset(
      radius + (radius * 0.1) * sin(degToRad(angle + 180)),
      radius - (radius * 0.1) * cos(degToRad(angle + 180)),
    );
    Offset minuteHand2 = Offset(
      radius + (radius * 0.7) * sin(degToRad(angle)),
      radius - (radius * 0.7) * cos(degToRad(angle)),
    );
    canvas.drawLine(minuteHand1, minuteHand2, minutePaint);
  }

  ///绘制秒针
  void drawSecond(Canvas canvas) {
    final second = dateTime.second;
    double angle = 360 / 60 * second;
    Offset secondHand1 = Offset(
      radius + (radius * 0.1) * sin(degToRad(angle + 180)),
      radius - (radius * 0.1) * cos(degToRad(angle + 180)),
    );
    Offset secondHand2 = Offset(
      radius + (radius * 0.7) * sin(degToRad(angle)),
      radius - (radius * 0.7) * cos(degToRad(angle)),
    );
    canvas.drawLine(secondHand1, secondHand2, secondPaint);
  }

  ///绘制中间圆圈
  void drawMiddleCircle(Canvas canvas) {
    canvas.drawCircle(Offset(radius, radius), middleCircleWidth, centerPaint);
  }

  ///绘制移动小球
  void drawMoveBall(Canvas canvas) {
    final second = dateTime.second;
    canvas.drawCircle(scaleOffset[second], middleCircleWidth, moveBallPaint);
  }
}

//角度转换为弧度
num degToRad(num deg) => deg * (pi / 180.0);
