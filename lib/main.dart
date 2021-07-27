import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_flutter/app/app.dart';
import 'package:my_flutter/app/route_helper.dart';
import 'package:my_flutter/base/flutter_lifecycle_state.dart';
import 'package:my_flutter/page/home_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: Locale("zh", "CH"),
        supportedLocales: [Locale("zh", "CH")],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        navigatorKey: App.navigatorKey,
        theme: ThemeData(
          canvasColor: Color(0xffF5F6F9),
        ),
        // routes: RouteHelper.routes,
        navigatorObservers: [routeObserver],
        home: HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          return CupertinoPageRoute(
              settings: settings,
              builder: (BuildContext context){
                //这里可以拦截做一些事情
                print("--------name=----${settings.name}");
               return RouteHelper?.routes[settings.name](context);
              }
          );
        }
    );
  }
}
