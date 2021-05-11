import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';
import 'package:my_flutter/widgets/floating_overall_view.dart';
import 'package:my_flutter/widgets/floating_view.dart';

///悬浮按钮Demo
class FloatingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FloatingState();
  }
}

class FloatingState extends State<FloatingPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: CustomAppBar(
            title: "悬浮按钮",
            onBack: () {
              Navigator.pop(context);
            }),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  "显示全局悬浮框",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  showFloating(context);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  "隐藏全局悬浮框",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  FloatingManager().dismissFloating();
                },
              ),
            ],
          ),
        ),
      ),

      ///旋转悬浮球
      FloatingView(
        backEdge: true,
        offset: Offset(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 3 / 4,
        ),
        child: RotationTransition(
          //设置动画的旋转中心
          alignment: Alignment.center,
          turns: _controller
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                _controller.reset();
                _controller.forward();
              }
            }),
          //将要执行动画的子view
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 40,
            backgroundImage: NetworkImage(
                "https://img1.baidu.com/it/u=2196634016,1990933817&fm=26&fmt=auto&gp=0.jpg"),
          ),
        ),
      ),

      ///没有定宽高的布局
      FloatingView(
        backEdge: false,
        offset: Offset(0, 200),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.deepOrange,
          ),
          child: Text("我是可以移动的哦"),
        ),
      ),
    ]);
  }
}
