import 'package:flutter/material.dart';

///悬浮按钮Demo
class FloatingView extends StatefulWidget {
  FloatingView({
    Key key,
    @required this.child,
    this.offset = Offset.infinite,
    this.backEdge = true,
    this.animTime = 500,
  }) : super(key: key);

  //悬浮Child
  Widget child;

  //初始位置
  Offset offset;

  //是否回归边缘
  bool backEdge;

  //动画时间
  int animTime;

  @override
  State<StatefulWidget> createState() {
    return FloatingViewState();
  }
}

class FloatingViewState extends State<FloatingView>
    with SingleTickerProviderStateMixin {
  //悬浮view的位置
  Offset offset = Offset.infinite;

  //悬浮view的key
  GlobalKey floatingKey = GlobalKey();

  //位移动画控制器
  AnimationController controller;

  //位移动画
  Animation<double> animation;

  //动画开始X
  double animStartX;

  //动画结束X
  double animEndX;

  //悬浮view宽高
  double width, height;

  //屏幕宽高
  double screenWidth, screenHeight;

  @override
  void initState() {
    super.initState();
    //初始化动画控制器
    controller = new AnimationController(
      duration: Duration(milliseconds: widget.animTime),
      vsync: this,
    );
    //Frame绘制完后进行回调，并只会回调一次
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //悬浮宽
      width = floatingKey.currentContext.size.width;
      //悬浮高
      height = floatingKey.currentContext.size.height;
      //获取屏幕信息
      final size = MediaQuery.of(context).size;
      //屏幕宽
      screenWidth = size.width;
      //屏幕高
      screenHeight = size.height;
      //悬浮位置设置
      offset = overflow(widget.offset);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: _floatingWindow(),
    );
  }

  /// 全局悬浮控件
  Widget _floatingWindow() {
    return GestureDetector(
      // HitTestBehavior.translucent   HitTestBehavior.opaque 自己处理事件
      // HitTestBehavior.deferToChild child处理事件
      // HitTestBehavior.translucent 自己和child都可以接收事件
      behavior: HitTestBehavior.deferToChild,
      //手指接触屏幕并可能开始移动
      onPanDown: (details) {
      },
      //手指接触屏幕并移动
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          //更新位置
          offset = offset + details.delta;
          //拖动时越界处理
          offset = overflow(offset);
        });
      },
      //手指离开屏幕
      onPanEnd: (details) {
        //是否回到边缘
        if (widget.backEdge) {
          //动画开始位置X
          double oldX = offset.dx;
          //抬手时 如悬浮view中心在屏幕左边就回归左边，否则右边
          if (offset.dx <= screenWidth / 2 - width / 2) {
            offset = Offset(0, offset.dy);
          } else {
            offset = Offset(screenWidth - width, offset.dy);
          }
          //动画结束位置X
          double newX = offset.dx;
          //创建动画
          animation = new Tween(begin: oldX, end: newX).animate(controller)
            ..addListener(() {
              setState(() {
                offset = Offset(animation.value, offset.dy);
              });
            });
          //执行动画
          controller.reset();
          controller.forward();
        }
      },
      child: Material(
        color: Colors.transparent,
        key: floatingKey,
        child: widget.child,
      ),
    );
  }



  ///越界处理
  Offset overflow(Offset offset) {
    if (offset.dx <= 0) {
      offset = Offset(0, offset.dy);
    }
    if (offset.dx >= screenWidth - width) {
      offset = Offset(screenWidth - width, offset.dy);
    }
    if (offset.dy <= 0) {
      offset = Offset(offset.dx, 0);
    }
    if (offset.dy >= screenHeight - height) {
      offset = Offset(offset.dx, screenHeight - height);
    }
    return offset;
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
