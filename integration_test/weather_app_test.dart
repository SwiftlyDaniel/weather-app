import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/widgets/weather_list_item.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Weather App Integration Test', () {
    testWidgets('Test weather data and unit toggle', (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      expect(find.textContaining('current temperature'), findsOneWidget);

      await tester.tap(find.byIcon(CupertinoIcons.thermometer));
      await tester.pumpAndSettle();

      expect(find.text('Select Temperature Unit'), findsOneWidget);
      expect(find.text('Celsius'), findsOneWidget);
      expect(find.text('Fahrenheit'), findsOneWidget);

      await tester.tap(find.text('Fahrenheit'));
      await tester.pumpAndSettle();

      expect(find.textContaining('°F'), findsWidgets);

      await tester.tap(find.byType(WeatherListItem).first);
      await tester.pumpAndSettle();

      expect(find.textContaining('current temperature'), findsOneWidget);
    });
  });
}
