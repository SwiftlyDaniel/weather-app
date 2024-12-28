import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'forecast.dart';

part 'weather.freezed.dart';

@freezed
class Weather with _$Weather {
  const factory Weather({
    required String cityName,
    required List<Forecast> forecast,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) {
    final cityName = json['city']['name'] as String;
    final forecastList = (json['list'] as List).map((e) => Forecast.fromJson(e as Map<String, dynamic>)).toList();

    final dailyForecasts = <Forecast>[];
    final Map<String, List<Forecast>> groupedByDay = {};

    for (var forecast in forecastList) {
      final day = DateFormat('yyyy-MM-dd').format(DateTime.parse(forecast.date));
      if (!groupedByDay.containsKey(day)) {
        groupedByDay[day] = [];
      }
      groupedByDay[day]!.add(forecast);
    }

    groupedByDay.forEach((day, forecasts) {
      final avgTemp = (forecasts.map((e) => e.temperature).reduce((a, b) => a + b) / forecasts.length).toStringAsFixed(1);
      final minTemp = forecasts.map((e) => e.temperature).reduce((a, b) => a < b ? a : b).toStringAsFixed(1);
      final maxTemp = forecasts.map((e) => e.temperature).reduce((a, b) => a > b ? a : b).toStringAsFixed(1);
      final currentTemp = forecasts.first.temperature.toStringAsFixed(1);
      final condition = forecasts.first.condition;
      final icon = forecasts.first.icon;
      final humidity = forecasts.first.humidity;
      final pressure = forecasts.first.pressure;
      final wind = forecasts.first.wind;

      dailyForecasts.add(Forecast(
        date: day,
        condition: condition,
        temperature: double.parse(avgTemp),
        minTemperature: double.parse(minTemp),
        maxTemperature: double.parse(maxTemp),
        currentTemperature: double.parse(currentTemp),
        icon: icon,
        humidity: humidity,
        pressure: pressure,
        wind: wind,
      ));
    });

    return Weather(cityName: cityName, forecast: dailyForecasts);
  }
}
