import 'dart:async';

import 'package:my_school/presentation/splash/splash_view_contract.dart';

class SplashPresenter{
  SplashViewContract _view;

  SplashPresenter(this._view);

  void initialize(){
    Timer timer;
    timer = new Timer(const Duration(seconds: 5), (){
      _view.navigateToHome();
    });
  }
}