import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_school/presentation/Schedule/SchedulePanel.dart';
import 'package:my_school/presentation/home/home_view.dart';
import 'package:my_school/presentation/login/login_view.dart';
import 'package:my_school/presentation/splash/splash_view.dart';
import 'package:my_school/utils/route_names.dart';
import 'package:fluro/fluro.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


Future main() async{
  await initDb();
  runApp(new MyApp());
}

Future initDb()async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, "qlhs.db");

  print(path);

  File db = new File(path);
  db.create();
  ByteData data = await rootBundle.load(join("assets", "qlhs.db"));
  List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes, data.lengthInBytes);
  await new File(path).writeAsBytes(bytes);
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