import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:my_school/services/stores/store_item.dart';
import 'package:path_provider/path_provider.dart';


class Store{
  Map<String, StoreItem> _items;

  Store(){
    _items = new Map<String, StoreItem>();
  }

  T getItem<T>(String key){
    if(_items.containsKey(key)){
      return _items[key].item;
    }
    else {
      return null;
    }
  }

  void setItem<T>(String key, T value){

    if(_items.containsKey(key)){
      _items[key].item = value;
    }
    else {
      _items[key] = new StoreItem<T>();
      _items[key].item = value;
    }
  }

  void addListener(String key, void Function(dynamic oldValue, dynamic newValue) f){
    _items[key].addListener(f);
  }

  void removeListener(String key, void Function(dynamic oldValue, dynamic newValue) f){
    _items[key].removeListener(f);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future save(String fileName)async {
    final path = await _localPath;
    File file = new File('$path/$fileName');
    var valueMap = new Map<String, dynamic>();
    _items.forEach((key, value){
      valueMap[key] = value.item;
    });
    file.writeAsString((new JsonCodec()).encode(valueMap));
  }

  Future load(String fileName) async {
    final path = await _localPath;
    File file = new File('$path/$fileName');
    if(await file.exists()){
      var json = await file.readAsString();

      Map<String, dynamic> map = (new JsonCodec()).decode(json);
      map.forEach((key, value){
        _items[key].item = value;
      });
    }
  }
}