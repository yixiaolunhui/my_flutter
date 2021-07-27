import 'package:flutter/material.dart';
import 'package:my_flutter/app/route_helper.dart';
import 'package:my_flutter/base/flutter_lifecycle_state.dart';
import 'package:my_flutter/page/test_page.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';

///主页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends StateWithLifecycle<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Flutter学习",
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              color: Colors.blue,
              height: 50,
              child: Text(
                "悬浮按钮",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteHelper.floatPage);
              },
            ),
            SizedBox(height: 50),
            MaterialButton(
              color: Colors.blue,
              height: 50,
              child: Text(
                "钟表",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteHelper.clockPage);
              },
            ),
            SizedBox(height: 50),
            MaterialButton(
              color: Colors.blue,
              height: 50,
              child: Text(
                "尺子",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteHelper.rulerPage);
              },
            ),
            SizedBox(height: 50),
            MaterialButton(
              color: Colors.blue,
              height: 50,
              child: Text(
                "结束",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteHelper.rosePage);
              },
            ),

            SizedBox(height: 50),
            MaterialButton(
              color: Colors.blue,
              height: 50,
              child: Text(
                "半透明的Widget",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                //跳转方式
                Navigator.push(context, DialogRoute(context: context, builder:(BuildContext context){
                  return TestPage();
                }));
                //dialog方式
                // showDialog(context: context, builder: (_) => TestPage());
              },
            ),
          ],
        ),
      ),
    );
  }



  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showFloating(context);
    // });
  }

  @override
  void onCreate() {
    super.onCreate();
    print("--------home=----onCreate");
  }

  @override
  void onPause() {
    super.onPause();
    print("--------home=----onPause");
  }

  @override
  void onResume() {
    super.onResume();
    print("--------home=----onResume");
  }

  @override
  void onDestroy() {
    super.onDestroy();
    print("--------home=----onDestroy");
  }

}
