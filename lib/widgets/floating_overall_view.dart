import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/floating_view.dart';

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
              offsetY: 200,
              child: child,
            ));
    Overlay.of(context).insert(overlayEntry);
  }

  void dismissFloating() {
    overlayEntry.remove();
    overlayEntry = null;
  }
}
