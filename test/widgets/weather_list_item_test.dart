import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/widgets/weather_list_item.dart';
import 'package:weather_app/utils/temperature.dart';

void main() {
  testWidgets('WeatherListItem displays weather information', (WidgetTester tester) async {
    final forecast = Forecast(
      date: '2023-01-01',
      condition: 'Clear',
      temperature: 10.0,
      minTemperature: 5.0,
      maxTemperature: 15.0,
      currentTemperature: 10.0,
      icon: '01d',
      humidity: 80,
      pressure: 1012,
      wind: 5.0,
    );

    await tester.pumpWidget(
      CupertinoApp(
        home: WeatherListItem(
          weather: forecast,
          onTap: () {},
          unit: TemperatureUnit.celsius,
        ),
      ),
    );

    expect(find.text('Sun'), findsOneWidget);
    expect(find.text('5.0°C / 15.0°C'), findsOneWidget);
  });
}
