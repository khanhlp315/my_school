import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_school/presentation/splash/splash_presenter.dart';
import 'package:my_school/presentation/splash/splash_view_contract.dart';
import 'package:my_school/utils/route_names.dart';

class SplashPage extends StatelessWidget{
  static const String routeName = RouteNames.SPLASH_PAGE;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: null,
        body: new SplashView()
    );
  }
}

class SplashView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new SplashState();
  }

}

class SplashState extends State <SplashView> implements SplashViewContract{
  SplashPresenter _presenter;

  SplashState(){
    _presenter = new SplashPresenter(this);
  }


  @override
  void initState() {
    super.initState();
    _presenter.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image(
                image: new AssetImage("assets/images/logo.png"),
              ),
              new Column(
                  children: <Widget>[
                    new Padding(
                        padding: new EdgeInsets.fromLTRB(
                            30.0, 40.0, 30.0, 15.0),
                        child:
                        new Row(
                            children: <Widget>[
                              new Text(
                                  "Xin chào thầy cô",
                                  maxLines: 5,
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    color: Colors.orange[300 ],
                                    fontSize: 20.0,
                                  ))
                            ])),
                    new Padding(
                        padding: new EdgeInsets.fromLTRB(
                            30.0, 15.0, 30.0, 5.0),
                        child:
                        new Row(
                            children: <Widget>[
                              new Text(
                                  "Đang cập nhật dữ liệu mới "
                                      "\n xin vui lòng chờ...."
                                  ,

                                  maxLines: 5,
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    color: Colors.blue[340],
                                    fontSize: 19.0,
                                  ))
                            ])),


                  ]),
            ]
        )
      ],

    );
  }

  @override
  void navigateToHome() {
    Router.appRouter.navigateTo(context, RouteNames.HOME_PAGE,
        replace: false, transition: TransitionType.fadeIn);

  }

}