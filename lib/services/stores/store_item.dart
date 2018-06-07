class StoreItem<T>{
  dynamic _item;
  List<void Function(T oldValue, T newValue)> _valueChangedListener;

  StoreItem(){
    _valueChangedListener = new List<void Function(T oldValue, T newValue)>();
  }

  T get item => _item;

  set item(T value) {
    var oldValue = _item;
    _item= value;

    _valueChangedListener.forEach((valueChangedListener){
      valueChangedListener(oldValue, _item);
    });
  }

  void addListener(void Function(T oldValue, T newValue) f){
    _valueChangedListener.add(f);
  }

  void removeListener(void Function(T oldValue, T newValue) f){
    _valueChangedListener.remove(f);
  }
}