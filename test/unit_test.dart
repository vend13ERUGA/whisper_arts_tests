import 'package:test/test.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';
import 'package:whisper_arts_tests/pages/basket/basket_singleton.dart';

void main() {
  test(
      'The final price should correspond to the sum of the prices of all products in the basket',
      () async {
    var clockData = ClockData(1, 'name', 'url', 'description', '10');
    var clockQuantity = ClockQuantity(clockData, 1);
    // final ttt = counter.getPrice();
    final basketSingleton = BasketSingleton();
    basketSingleton.addAll(clockQuantity);
    // yyyy.basketList = uuuu;
    var result = basketSingleton.getPrice();
    // await BasketFavourutesDatabase.instance.initDB('basket.db');
    // final yyyyyy = yyyy.initDB(); // await yyy.initDB();
    // await yyy.loadInDatabase();
    expect(result, 10);
  });
}
