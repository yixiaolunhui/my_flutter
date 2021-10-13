import 'dart:math' hide Point;
import 'dart:ui';

import 'package:my_flutter/widgets/flutter_carousel.dart';

class CarouselUtil {
  ///计算Widget的位置
  static Offset point(
    double radius,
    double cirAngle,
    double centerX,
    double centerY,
  ) {
    final double arcAngle = cirAngle * pi / 180;
    final double x = centerX + cos(arcAngle) * radius;
    final double y = centerY + sin(arcAngle) * radius;
    return Offset(x, y);
  }

  ///弧度换算成角度
  static double radianToAngle(double radian) {
    return radian * 180 / (pi);
  }

  ///角度换算成弧度
  static double angleToRadian(double angle) {
    return angle * pi / 180;
  }

  ///对子控件排序（按照从后往前排）
  static List<Point> sortChildList(List<Point> childList, Size size) {
    List<Point> result = [];
    //左边的子控件集合
    List<Point> leftChildList = [];
    //右边的子控件集合
    List<Point> rightChildList = [];
    //子控件集合拆分为2个集合，左边及右边
    childList?.forEach((child) {
      //根据子控件的中心的x坐标与中心点x左边对比区分
      if (child.centerX <= size.width / 2) {
        leftChildList.add(child);
      } else {
        rightChildList.add(child);
      }
    });
    //按照y坐标排序
    leftChildList.sort((a, b) => (a.centerY).compareTo(b.centerY));
    rightChildList.sort((a, b) => (a.centerY).compareTo(b.centerY));

    var leftIndex = 0;
    var rightIndex = 0;
    var length = max(leftChildList?.length ?? 0, rightChildList?.length ?? 0);
    //按照左右2个集合，一个个的添加
    while (length >= 0) {
      //左边
      if (leftIndex < leftChildList?.length ?? 0) {
        result.add(leftChildList[leftIndex]);
        leftIndex++;
      }
      //右边
      if (rightIndex < rightChildList?.length ?? 0) {
        result.add(rightChildList[rightIndex]);
        rightIndex++;
      }
      length--;
    }
    return result;
  }

  ///l(弧长)=2πr×角度/360
  static double angle(double l, double radius) {
    return l * 360 / (2 * pi * (radius));
  }


  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }
}
