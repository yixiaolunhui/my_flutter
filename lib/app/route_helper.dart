import 'package:flutter/material.dart';
import 'package:my_flutter/page/clock_page.dart';
import 'package:my_flutter/page/floating_page.dart';
import 'package:my_flutter/page/home_page.dart';
import 'package:my_flutter/page/other/textformfield_page.dart';
import 'package:my_flutter/page/rose_page.dart';
import 'package:my_flutter/page/ruler_page.dart';
import 'package:my_flutter/page/study/canvas_page.dart';
import 'package:my_flutter/page/study_page.dart';

///路由管理
class RouteHelper {
  ///主模块
  static const String homePage = 'home';

  ///悬浮按钮
  static const String floatPage = 'floating';

  ///钟表
  static const String clockPage = 'clock';

  ///尺子
  static const String rulerPage = 'ruler';

  ///输入框相关
  static const String textFormFieldPage = 'text_from_field';

  ///玫瑰花
  static const String rosePage = 'rose';

  ///学习
  static const String studyPage = 'study';

  ///Canvas
  static const String canvasPage = 'canvas';

  ///路由与页面绑定注册
  static Map<String, WidgetBuilder> routes = {
    homePage: (context) => HomePage(),
    floatPage: (context) => FloatingPage(),
    clockPage: (context) => ClockPage(),
    rulerPage: (context) => RulerPage(),
    textFormFieldPage: (context) => TextFormFieldPage(),
    rosePage: (context) => RosePage(),
    studyPage: (context) => StudyPage(),
    canvasPage: (context) => CanvasPage(),
  };
}
