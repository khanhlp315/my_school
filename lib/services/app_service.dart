import 'package:my_school/di/injection.dart';
import 'package:my_school/presentation/login/login_service_contract.dart';
import 'package:my_school/services/stores/app_store.dart';

class AppService implements LoginServiceContract {
  @override
  AppStore getStore() {
    return new Injector().appStore;
  }

}