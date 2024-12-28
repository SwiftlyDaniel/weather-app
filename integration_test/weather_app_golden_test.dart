import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const Size iPhone16Portrait = Size(430, 932);
  const Size iPhone16Landscape = Size(932, 430);

  const Size iPadPro11Portrait = Size(834, 1194);
  const Size iPadPro11Landscape = Size(1194, 834);

  Future<void> runGoldenTest(WidgetTester tester, Size size, String device, String orientation) async {
    await tester.binding.setSurfaceSize(size);

    app.main();
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CupertinoPageScaffold),
      matchesGoldenFile('test_goldens/${device}_weather_screen_$orientation.png'),
    );

    await tester.binding.setSurfaceSize(null);
  }

  group('Weather App Golden Test', () {
    testWidgets('iPhone 16 Portrait Golden Test', (WidgetTester tester) async {
      await runGoldenTest(tester, iPhone16Portrait, 'iPhone16', 'portrait');
    });

    testWidgets('iPhone 16 Landscape Golden Test', (WidgetTester tester) async {
      await runGoldenTest(tester, iPhone16Landscape, 'iPhone16', 'landscape');
    });

    testWidgets('iPad Pro 11" Portrait Golden Test', (WidgetTester tester) async {
      await runGoldenTest(tester, iPadPro11Portrait, 'iPadPro11', 'portrait');
    });

    testWidgets('iPad Pro 11" Landscape Golden Test', (WidgetTester tester) async {
      await runGoldenTest(tester, iPadPro11Landscape, 'iPadPro11', 'landscape');
    });
  });
}
