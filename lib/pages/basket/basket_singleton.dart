class BasketSingleton {
  static BasketSingleton? _basketSingleton;
  final List<int> clockID = [];

  void addID(int ID) {
    clockID.add(ID);
  }

  void deleteID(int ID) {
    clockID.remove(ID);
  }

  void deleteAll() {
    clockID.clear();
  }

  factory BasketSingleton() {
    _basketSingleton ??= BasketSingleton._internal();
    return _basketSingleton as BasketSingleton;
  }

  BasketSingleton._internal();
}
