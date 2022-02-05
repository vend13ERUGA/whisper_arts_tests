import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:whisper_arts_tests/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('add the product to the basket, make a purchase',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Oyster Perpetual 41'));
      await tester.pumpAndSettle();

      final Finder inBasket = find.text('Положить в корзину');
      await tester.tap(inBasket);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('basket')));
      await tester.pumpAndSettle();
      // expect(find.text('Oyster Perpetual 41'), findsOneWidget);

      await tester.tap(find.text('Купить'));
      await tester.pumpAndSettle();
      expect(find.text('Покупка совершена'), findsOneWidget);
    });
  });
}
