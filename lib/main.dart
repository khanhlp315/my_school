import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_school/presentation/Schedule/SchedulePanel.dart';
import 'package:my_school/presentation/home/home_view.dart';
import 'package:my_school/presentation/login/login_view.dart';
import 'package:my_school/presentation/splash/splash_view.dart';
import 'package:my_school/utils/route_names.dart';
import 'package:fluro/fluro.dart';


Future main() async{
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  MyApp(){
    Router.appRouter.define(RouteNames.LOGIN_PAGE, handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new LoginPage();
    }));
    Router.appRouter.define(RouteNames.SPLASH_PAGE, handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new SplashPage();
    }));
    Router.appRouter.define(RouteNames.HOME_PAGE, handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new HomeView();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "My School",
      home: new SchedulePanel(),
      onGenerateRoute: Router.appRouter.generator,
    );
  }

}