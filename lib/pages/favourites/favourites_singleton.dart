import 'package:whisper_arts_tests/dataclass/clock_data.dart';

class FavouritesSingleton {
  static FavouritesSingleton? _favoriteSingleton;
  final List<ClockQuantity> _favouritesList = [];

  Iterable<ClockData> getFavouritesList() {
    return _favouritesList.map((e) => e.clockData);
  }

  bool hasIDInFavourites(int ID) {
    return _favouritesList.any((element) => element.clockData.id == ID);
  }

  void delete(int ID) {
    for (int i = 0; i <= _favouritesList.length; i++) {
      if (_favouritesList[i].clockData.id == ID) {
        _favouritesList.remove(_favouritesList[i]);
        break;
      }
    }
  }

  void add(ClockData clockData) {
    ClockQuantity clockQuantity = ClockQuantity(clockData, 1);
    _favouritesList.add(clockQuantity);
  }

  void addAll(ClockQuantity clockQuantity) {
    _favouritesList.add(clockQuantity);
  }

  bool isEmpty() => _favouritesList.isEmpty;

  factory FavouritesSingleton() {
    _favoriteSingleton ??= FavouritesSingleton._internal();
    return _favoriteSingleton!;
  }

  FavouritesSingleton._internal();
}
