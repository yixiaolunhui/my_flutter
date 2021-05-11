import 'package:flutter/material.dart';
import 'package:my_flutter/app/route_helper.dart';
import 'package:my_flutter/widgets/floating_view.dart';

///弹出全局悬浮窗
void showFloating(BuildContext context) {
  Future.delayed(const Duration(milliseconds: 500), () {
    FloatingManager().showFloating(
      context: context,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteHelper.studyPage);
        },
        child: CircleAvatar(
          backgroundColor: Colors.red,
          radius: 40,
          child: Text(
            "学",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  });
}

///全局浮窗
class FloatingManager {
  static final FloatingManager _instance = new FloatingManager._internal();

  factory FloatingManager() {
    return _instance;
  }

  FloatingManager._internal();

  OverlayEntry overlayEntry;

  void showFloating({BuildContext context, Widget child}) {
    if (overlayEntry != null) return;
    overlayEntry = OverlayEntry(
        builder: (context) => FloatingView(
              offset: Offset(MediaQuery.of(context).size.width, 200),
              child: child,
            ));
    Overlay.of(context).insert(overlayEntry);
  }

  void dismissFloating() {
    overlayEntry.remove();
    overlayEntry = null;
  }
}
