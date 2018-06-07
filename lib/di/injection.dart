import 'package:my_school/presentation/login/login_service_contract.dart';
import 'package:my_school/services/app_service.dart';
import 'package:my_school/services/stores/app_store.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  static final AppStore _appStore = new AppStore();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  //services
  LoginServiceContract get loginService => new AppService();

  //stores
  AppStore get appStore => _appStore;
}