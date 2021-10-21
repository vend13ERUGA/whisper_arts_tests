import 'package:whisper_arts_tests/dataclass/clock_data.dart';

class BasketSingleton {
  static BasketSingleton? _basketSingleton;
  final List<ClockQuantity> _basketList = [];

  Iterable<ClockData> getBasketList() {
    return _basketList.map((e) => e.clockData);
  }

  bool hasIDInBasket(int ID) {
    return _basketList.any((element) => element.clockData.id == ID);
  }

  String getQuantity(int ID) {
    int quantity = 0;
    for (var clock in _basketList) {
      if (clock.clockData.id == ID) {
        quantity = clock.quantity;
        break;
      }
    }
    return quantity.toString();
  }

  void incrementQuantity(int ID) {
    int quantity = 0;
    for (var clock in _basketList) {
      if (clock.clockData.id == ID) {
        clock.quantity++;
        break;
      }
    }
  }

  void decrementQuantity(int ID) {
    int quantity = 0;
    for (var clock in _basketList) {
      if (clock.clockData.id == ID) {
        if (clock.quantity >= 2) {
          clock.quantity--;
          break;
        } else {
          break;
        }
      }
    }
  }

  void delete(int ID) {
    for (int i = 0; i <= _basketList.length; i++) {
      if (_basketList[i].clockData.id == ID) {
        _basketList.remove(_basketList[i]);
        break;
      }
    }
  }

  void add(ClockData clockData) {
    ClockQuantity clockQuantity = ClockQuantity(clockData, 1);
    _basketList.add(clockQuantity);
  }

  void addAll(ClockQuantity clockQuantity) {
    _basketList.add(clockQuantity);
  }

  void deleteAll() {
    _basketList.clear();
  }

  bool isEmpty() => _basketList.isEmpty;
  int getPrice() {
    int price = 0;
    for (var item in _basketList) {
      price = price + int.parse(item.clockData.price) * item.quantity;
    }
    return price;
  }

  String convertPrise() {
    var price = getPrice();
    if (price > 999 && price <= 999999) {
      if (price % 1000 == 0) {
        int div = price ~/ 1000;
        return div.toString() + "K";
      } else {
        double divmod = price / 1000;
        return divmod.toString() + "K";
      }
    } else if (price > 999999 && price < 999999999) {
      if (price % 1000000 == 0) {
        int div = price ~/ 1000000;
        return div.toString() + "M";
      } else {
        double divmod = price / 1000000;
        return divmod.toString() + "M";
      }
    } else if (price > 999999999) {
      if (price % 1000000000 == 0) {
        int div = price ~/ 1000000000;
        return div.toString() + "MM";
      } else {
        double divmod = price / 1000000000;
        return divmod.toString() + "MM";
      }
    } else {
      return price.toString();
    }
  }

  factory BasketSingleton() {
    _basketSingleton ??= BasketSingleton._internal();
    return _basketSingleton!;
  }

  BasketSingleton._internal();
}
