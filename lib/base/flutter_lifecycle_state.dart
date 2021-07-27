import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

abstract class StateWithLifecycle<T extends StatefulWidget> extends State
    with WidgetsBindingObserver, RouteAware {
  String tagInStateWithLifecycle = 'StateWithLifecycle';

  // 参照State中写法，防止子类获取不到正确的widget。
  T get widget => super.widget;

  bool _isVisibleToUser =
      false; // 是否对用户可见，表明在onResume-onPause调用过程中。也用来表示当前页面是否在栈顶。

  // onResume、onPause方法事件是否是由系统触发的。也就是AppLifecycleState.resumed和AppLifecycleState.paused中触发。
  // 在从paused到resumed这个过程中，_systemDispatched的值为true。
  bool _systemDispatched = false;

  bool _didPush = false; // 表示是否调用了didPush方法。第一次进入会调用
  bool _didPopNext = false; // 表示是否调用了didPopNext方法。进入别的页面，再次返回时会调用。
  bool _didPop = false; // 表示是否调用了didPop方法。从Navigator中pop时会调用。

  // 一级页面进入二页面再返回，此时回调正常。再次进入二级页面时，不会调用一级页面的onPause方法。
  // 同理，再次返回时也不会调用onResume方法，所以这里引入了一个计数器。
  int _didPopNextCount = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('$tagInStateWithLifecycle --> initState');
    _onMockCreate();
    _onMockResume();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void deactivate() {
    debugPrint('$tagInStateWithLifecycle --> deactivate');
    debugPrint(
        '$tagInStateWithLifecycle --> deactivate _didPop:$_didPop, _didPush:$_didPush, _didPopNext:$_didPopNext, _didPopNextCount:$_didPopNextCount');
    super.deactivate();
    if (_didPop || _didPush || _didPopNextCount == 1) {
      _onMockPause();
    } else if (_didPopNext) {
      _onMockResume();
    }
    _resetValues();
  }

  /// 重置这三个变量
  void _resetValues() {
    _didPop = false;
    _didPopNext = false;
    _didPush = false;
    _didPopNextCount--;
  }

  @override
  void dispose() {
    debugPrint('$tagInStateWithLifecycle --> dispose');
    _onMockDestroy();
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint('$tagInStateWithLifecycle --> AppLifecycleState.resumed');
        _onMockResume();
        _systemDispatched = false;
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        debugPrint('$tagInStateWithLifecycle --> AppLifecycleState.paused');
        _systemDispatched = true;
        _onMockPause();
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    debugPrint('$tagInStateWithLifecycle:didPush');
    _didPush = true;
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    debugPrint('$tagInStateWithLifecycle:didPopNext');
    _didPopNext = true;
    _didPopNextCount = 2;
    _isVisibleToUser = false;
    _onMockResume();
  }

  @override
  void didPop() {
    debugPrint('$tagInStateWithLifecycle:didPop');
    _didPop = true;
  }

  /// 页面初始化调用，只会调用一次。参照Android端Activity#onCreate方法。
  void _onMockCreate() {
    debugPrint("$tagInStateWithLifecycle:onMockCreate");
    onCreate();
  }

  /// 页面由不可见变为可见时调用。
  @mustCallSuper
  void _onMockResume() {
    // 满足这两个条件时才会执行：_systemDispatched和_isVisibleToUser均为true，_systemDispatched和_isVisibleToUser均为false。
    if (_systemDispatched && _isVisibleToUser ||
        !_systemDispatched && !_isVisibleToUser) {
      _isVisibleToUser = true;
      debugPrint(
          "$tagInStateWithLifecycle:onMockResume _isVisiableToUser:$_isVisibleToUser");
      onResume();
    }
  }

  /// 页面有可见变为不可见时调用。
  @mustCallSuper
  void _onMockPause() {
    if (!_isVisibleToUser) {
      return;
    }
    // 这一步很关键，在系统传递paused事件过来时，_systemDispatched的值为true，此时不会将_isVisibleToUser的值置为false，是为了跟别的页面区分。
    if (!_systemDispatched) {
      _isVisibleToUser = false;
    }
    debugPrint(
        "$tagInStateWithLifecycle:onMockPause _isVisiableToUser:$_isVisibleToUser");
    onPause();
  }

  /// 页面销毁时调用。
  /// 这里需要说明的时，不管是纯flutter应用还是混合开发的应用，在根flutter页面返回时，都不会调用它的dispose方法。这就需要我们自己
  void _onMockDestroy() {
    debugPrint("$tagInStateWithLifecycle:onMockDestroy");
    onDestroy();
  }

  /// 用于让子类去实现的初始化方法
  void onCreate() {
    debugPrint('$tagInStateWithLifecycle --> onCreate()');
  }

  /// 用于让子类去实现的不可见变为可见时的方法
  void onResume() {
    debugPrint('$tagInStateWithLifecycle --> onResume()');
  }

  /// 用于让子类去实现的可见变为不可见时调用的方法。
  void onPause() {
    debugPrint('$tagInStateWithLifecycle --> onPause()');
  }

  /// 用于让子类去实现的销毁方法。
  void onDestroy() {
    debugPrint('$tagInStateWithLifecycle --> onDestroy()');
  }
}
