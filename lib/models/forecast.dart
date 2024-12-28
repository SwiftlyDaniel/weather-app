import 'package:freezed_annotation/freezed_annotation.dart';

part 'forecast.freezed.dart';

@freezed
class Forecast with _$Forecast {
  const factory Forecast({
    required String date,
    required String condition,
    required double temperature,
    required double minTemperature,
    required double maxTemperature,
    required double currentTemperature,
    required String icon,
    required int humidity,
    required int pressure,
    required double wind,
  }) = _Forecast;

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final date = json['dt_txt'] as String;
    final condition = (json['weather'] as List).first['main'] as String;
    final temperature = (json['main']['temp'] as num).toDouble();
    final icon = (json['weather'] as List).first['icon'] as String;
    final humidity = json['main']['humidity'] as int;
    final pressure = json['main']['pressure'] as int;
    final wind = (json['wind']['speed'] as num).toDouble();
    return Forecast(
      date: date,
      condition: condition,
      temperature: temperature,
      minTemperature: 0, // Placeholder, will be calculated later
      maxTemperature: 0, // Placeholder, will be calculated later
      currentTemperature: 0, // Placeholder, will be calculated later
      icon: icon,
      humidity: humidity,
      pressure: pressure,
      wind: wind,
    );
  }
}
