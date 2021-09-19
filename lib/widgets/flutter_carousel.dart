import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

///选择木马布局
class CarouselLayout extends StatefulWidget {
  CarouselLayout({
    Key key,
    this.children,
    this.childWidth = 60,
    this.childHeight = 60,
    this.deviationRatio = 0.2,
    this.minScale = 0.8,
    this.isAuto = false,
  }) : super(key: key);

  //所有的子控件
  final List<Widget> children;

  //每个子控件的宽
  final double childWidth;

  //每个子控件的高
  final double childHeight;

  //偏移X系数  0-1
  final double deviationRatio;

  //最小缩放比 子控件的滑动时最小比例
  final double minScale;

  final bool isAuto;

  @override
  State<StatefulWidget> createState() => CarouselState();
}

class CarouselState extends State<CarouselLayout>
    with TickerProviderStateMixin {
  //自动旋转角度 每16毫秒移动的角度
  double AUTO_SWEEP_ANGLE = 0.2;

  //滑动系数
  final slipRatio = 0.9;

  //开始角度
  double startAngle = 270;

  //旋转角度
  double rotateAngle = 0.0;

  //按下时X坐标
  double downX = 0.0;

  //按下时的角度
  double downAngle = 0.0;

  //半径
  double radius = 0.0;

  Timer _rotateTimer;

  AnimationController controller;

  Animation<double> animation;

  double velocityX;

  @override
  void didUpdateWidget(covariant CarouselLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (this.widget.isAuto) {
      _startRotateTimer();
    } else {
      _cancelRotateTimer();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted)
        setState(() {
          if (this.widget.isAuto) {
            _startRotateTimer();
          }
        });
    });

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    animation = new Tween<double>(begin: 1, end: 0).animate(animation)
      ..addListener(() {
        //当前速度
        var velocity = animation.value * -velocityX;
        var offsetX = (velocity * 5) / (2 * pi * radius);
        rotateAngle += offsetX;
        setState(() => {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (this.widget.isAuto) {
            _startRotateTimer();
          }
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _cancelRotateTimer();
    controller?.dispose();
  }

  ///开始自动旋转计时器
  _startRotateTimer() {
    if (_rotateTimer == null) {
      _rotateTimer = new Timer.periodic(new Duration(milliseconds: 1), (timer) {
        rotateAngle += AUTO_SWEEP_ANGLE;
        rotateAngle %= 360; // 取个模 防止sweepAngle爆表
        setState(() {});
      });
    }
  }

  ///取消自动旋转计时器
  _cancelRotateTimer() {
    _rotateTimer?.cancel();
    _rotateTimer = null;
  }

  ///子控件集
  _childList({Size size = Size.zero}) {
    //所有的子布局
    List<Widget> childList = [];
    if (this.widget.children?.isNotEmpty ?? false) {
      //子控件数量
      int count = this.widget.children.length;
      //平均角度
      double averageAngle = 360 / (count);
      //半径
      radius = size.width / 2 - this.widget.childWidth / 2;
      List<Point> sortList = [];
      for (int i = 0; i < count; i++) {
        double angle = (startAngle - averageAngle * i + rotateAngle) * pi / 180;
        var sinValue = sin(angle);
        var cosValue = cos(angle);
        var coordinateX = size.width / 2 - radius * cosValue;
        var coordinateY = size.height / 2 -
            radius * sinValue * sin(pi / (1 + this.widget.deviationRatio));
        var minScale = min(this.widget.minScale, 0.99);
        var scale = ((1 - minScale) / 2 * (1 - sin(angle)) + minScale);

        var child = Positioned(
          width: this.widget.childWidth * scale,
          height: this.widget.childHeight * scale,
          child: this.widget.children[i],
          left: coordinateX - this.widget.childWidth * scale / 2,
          top: coordinateY - this.widget.childHeight * scale / 2,
        );
        sortList.add(Point(
          i,
          coordinateX - this.widget.childWidth * scale / 2,
          coordinateY + this.widget.childHeight * scale / 2,
          scale,
          child,
          angle,
        ));
      }
      _sortChildList(sortList, size).forEach((item) {
        childList.add(item.child);
      });
    }
    return childList;
  }

  List<Point> _sortChildList(List<Point> childList, Size size) {
    List<Point> list = [];
    List<Point> result = [];
    List<Point> leftChildList = [];
    List<Point> rightChildList = [];
    childList?.forEach((child) {
      if (child.x <= size.width / 2) {
        leftChildList.add(child);
      } else {
        rightChildList.add(child);
      }
    });
    leftChildList.sort((a, b) => (a.y).compareTo(b.y));
    rightChildList.sort((a, b) => (a.y).compareTo(b.y));
    leftChildList.forEach((element) {
      list.add(element);
    });
    rightChildList.reversed.forEach((element) {
      list.add(element);
    });
    var index = 0;
    while (result.length != list.length) {
      if (result.length != list.length) {
        result.add(list[index]);
      }
      if (result.length != list.length) {
        result.add(list[list.length - 1 - index]);
      }
      index++;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (
      BuildContext context,
      BoxConstraints constraints,
    ) {
      return GestureDetector(
        ///滑动开始
        onHorizontalDragStart: (DragStartDetails details) {
          //取消自动移动定时器
          _cancelRotateTimer();
          controller?.stop();
          downAngle = rotateAngle;
          downX = details.globalPosition.dx;
        },

        ///滑动中
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          var updateX = details.globalPosition.dx;
          rotateAngle = (downX - updateX) * slipRatio + downAngle;
          if (mounted) setState(() {});
        },

        ///滑动结束
        onHorizontalDragEnd: (DragEndDetails details) {
          velocityX = details.velocity.pixelsPerSecond.dx;
          controller.reset();
          controller.forward();
        },
        child: CustomPaint(
          size: constraints.biggest,
          painter: CarouselPainter(),
          child: Stack(
            children: _childList(size: constraints.biggest),
          ),
        ),
      );
    });
  }
}

class Point {
  Point(
    this.index,
    this.x,
    this.y,
    this.scale,
    this.child,
    this.angle,
  );

  double x;
  double y;
  double scale;
  int index;
  Widget child;
  double angle;

  @override
  String toString() {
    StringBuffer valueBuffer = new StringBuffer();
    valueBuffer
      ..write("x=$x ")
      ..write("y=$y ")
      ..write("scale=$scale ")
      ..write("index=$index ")
      ..write("angle=$angle ");
    return valueBuffer.toString();
  }
}

class CarouselPainter extends CustomPainter {
  CarouselPainter({
    this.children,
  });

  final List<Widget> children;

  double width, height;

  @override
  void paint(Canvas canvas, Size size) {
    width = size.width;
    height = size.height;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
