import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_school/presentation/login/login_presenter.dart';
import 'package:my_school/presentation/login/login_view_contract.dart';
import 'package:my_school/utils/route_names.dart';

class LoginPage extends StatelessWidget{
  static const String routeName = RouteNames.LOGIN_PAGE;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: null,
        body: new LoginView()
    );
  }
}

class LoginView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }

}

class LoginState extends State<LoginView> implements LoginViewContract{
  LoginPresenter _presenter;

  bool _showPassword;

  TextEditingController _usernameTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();

  LoginState(){
    _presenter = new LoginPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children:
      <Widget>[
        new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image(
                image: new AssetImage("assets/logo.png"),
              ),
              new Column(
                children: <Widget>[ new Padding(
                    padding: new EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                    child:
                    new Row(
                        children: <Widget>[
                          new Text(
                              "Tên đăng nhập",
                              textAlign: TextAlign.start,
                              style: new TextStyle(color: Colors.black,
                                fontSize: 20.0,
                              ))
                        ])),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0.0),
                  child: new TextFormField(
                    controller: _usernameTextController,
                    decoration: new InputDecoration(
                        hintText: "Nhập tài khoản"
                    ),
                  ),
                ),
                ], //widget
              ), //column
              new Column(
                children: <Widget>[ new Padding(
                    padding: new EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0.0),
                    child:
                    new Row(
                        children: <Widget>[
                          new Text(
                              "Mật khẩu ",
                              textAlign: TextAlign.start,
                              style: new TextStyle(color: Colors.black,
                                fontSize: 20.0,
                              ))
                        ])),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0.0),
                  child: new TextFormField(
                    controller: _passwordTextController,
                    decoration: new InputDecoration(
                        hintText: "Nhập mật khẩu"
                    ),
                    obscureText: !_showPassword,
                  ),
                ),
                new Padding(
                    padding: new EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0.0),
                    child: new Row(
                        children: <Widget>[
                          new Checkbox(
                              value: _showPassword,
                              activeColor: Colors.blue[500],
                              onChanged: (bool value) {
                                _presenter.setShowPassword(value);
                              }),

                          new Text(
                              "Hiện mật khẩu",
                              style: new TextStyle(color: Colors.black,
                                fontSize: 10.0,
                              )
                          )
                        ])),
                new RaisedButton(
                  child: new Text(
                    "Đăng nhập",
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  elevation: 4.0,
                  color: Colors.blue[400],
                  disabledColor: Colors.blue[400],
                  highlightColor: Colors.blue[400],
                  splashColor: Colors.blue[200],
                  onPressed: () {
                    if (_usernameTextController.text == "Phong") {
                      _presenter.resetWrongCount();
                      _presenter.onLoginSucceeded();

                    }
                    else {
                      _presenter.increaseWrongCount();

                    }
                  },),
                new FlatButton(
                  child: new Text(
                    "Đăng ký",
                    style: new TextStyle(
                      color: Colors.blue[500],
                      fontSize: 15.0,
                      decoration: TextDecoration.underline,
                    ),),
                  onPressed: () {
                    //To SignUpView
                    Navigator.of(context).pushNamed('/a3');
                  }
                  ,),
                new FlatButton(
                  child: new Text(
                    "Quên mật khẩu ?",
                    style: new TextStyle(
                      color: Colors.blue[500],
                      fontSize: 15.0,
                      decoration: TextDecoration.underline,
                    ),),
                  onPressed: () {
                    //To GetPasswordView
                    Navigator.of(context).pushNamed('/a2');
                  }
                  ,),
                ],
              )
            ]),
      ],
    );
  }

  @override
  void navigateToGetPassword() {
    // TODO: implement navigateToGetPassword
  }

  @override
  void navigateToSignup() {
    // TODO: implement navigateToSignup
  }

  @override
  void navigateToWrongPassword() {
    // TODO: implement navigateToWrongPassword
  }

  @override
  void navigateToLoadingView() {
    Router.appRouter.navigateTo(context, RouteNames.SPLASH_PAGE,
        replace: false, transition: TransitionType.fadeIn);
  }

  @override
  void hidePassword() {
    if(mounted){
      setState(() {
        _showPassword = false;
      });
    }
    else {
      _showPassword = false;
    }
  }

  @override
  void showPassword() {
    if(mounted){
      setState(() {
        _showPassword = true;
      });
    }
    else {
      _showPassword = true;
    }
  }

}