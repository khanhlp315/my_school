import 'package:my_school/di/injection.dart';
import 'package:my_school/presentation/login/login_service_contract.dart';
import 'package:my_school/presentation/login/login_view_contract.dart';

class LoginPresenter{
  LoginViewContract _view;

  LoginServiceContract _service;

  LoginPresenter(this._view){
    _service = new Injector().loginService;
    _view.hidePassword();
  }

  void resetWrongCount() {
    var store = _service.getStore();
    store.storeWrongCount(0);
  }

  void increaseWrongCount() {
    var store = _service.getStore();
    int wrongCount = store.getWrongCount();

    if(++wrongCount > 5){
      _view.navigateToWrongPassword();
    }
  }

  void onLoginSucceeded() {
    _view.navigateToLoadingView();
  }

  void setShowPassword(bool value) {
    if(value){
      _view.showPassword();
    }
    else {
      _view.hidePassword();
    }
  }
}