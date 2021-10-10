import 'package:whisper_arts_tests/dataclass/clock_data.dart';

class BasketSingleton {
  static BasketSingleton? _basketSingleton;
  final List<ClockData> _clockIDList = [];

  Iterable<ClockData> getBasketList() sync* {
    for (var item in _clockIDList) {
      yield item;
    }
  }

  bool findIDInBasket(int ID) {
    bool counter = false;
    for (var item in _clockIDList) {
      if (item.id == ID) {
        counter = true;
        break;
      }
    }
    return counter;
  }

  void delete(int ID) {
    for (int i = 0; i <= _clockIDList.length; i++) {
      if (_clockIDList[i].id == ID) {
        _clockIDList.remove(_clockIDList[i]);
        break;
      }
    }
  }

  bool checkingForEmptiness() {
    if (_clockIDList.isEmpty)
      return false;
    else
      return true;
  }

  void add(ClockData clockData) {
    _clockIDList.add(clockData);
  }

  void deleteAll() {
    _clockIDList.clear();
  }

  int getPrice() {
    int price = 0;
    for (var item in _clockIDList) {
      price = price + int.parse(item.price);
    }
    return price;
  }

  factory BasketSingleton() {
    _basketSingleton ??= BasketSingleton._internal();
    return _basketSingleton as BasketSingleton;
  }

  BasketSingleton._internal();
}
