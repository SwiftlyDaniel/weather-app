import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import '../models/forecast.dart';
import '../utils/date.dart';
import '../utils/temperature.dart';

class WeatherDetail extends StatelessWidget {
  final Forecast weather;
  final bool isCurrentDay;
  final TemperatureUnit unit;

  const WeatherDetail({
    super.key,
    required this.weather,
    this.isCurrentDay = false,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              formatDate(weather.date),
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            weather.condition,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.lightBackgroundGray,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: 'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                  errorWidget: (context, url, error) => const Text('Weather condition image not found'),
                  height: 100,
                  placeholder: (context, url) => const CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              formatTemperature(isCurrentDay ? weather.currentTemperature : weather.temperature, unit),
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 50, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              '(${isCurrentDay ? 'current' : 'average'} temperature)',
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
          ),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              style: CupertinoTheme.of(context).textTheme.textStyle,
              children: [
                TextSpan(
                  text: 'Humidity: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${weather.humidity}%',
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              style: CupertinoTheme.of(context).textTheme.textStyle,
              children: [
                TextSpan(
                  text: 'Pressure: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${weather.pressure} hPa',
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              style: CupertinoTheme.of(context).textTheme.textStyle,
              children: [
                TextSpan(
                  text: 'Wind: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${weather.wind} km/h',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
