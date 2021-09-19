import 'dart:math';
import 'dart:ui';

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
}
