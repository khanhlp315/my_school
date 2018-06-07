import 'package:my_school/services/stores/store.dart';

class AppStore {
  static const String WRONG_COUNT = "WRONG_COUNT";

  Store _store;

  AppStore(){
    _store = new Store();
    _store.setItem<int>(WRONG_COUNT, 0);
  }

  void storeWrongCount(int value){
    _store.setItem(WRONG_COUNT, value);
  }

  int getWrongCount(){
    return _store.getItem(WRONG_COUNT);
  }
}