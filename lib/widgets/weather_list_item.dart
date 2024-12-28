import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import '../models/forecast.dart';
import '../utils/date.dart';
import '../utils/temperature.dart';

class WeatherListItem extends StatelessWidget {
  final Forecast weather;
  final VoidCallback onTap;
  final bool isActive;
  final TemperatureUnit unit;

  const WeatherListItem({
    super.key,
    required this.weather,
    required this.onTap,
    this.isActive = false,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isActive ? CupertinoColors.systemBlue.withOpacity(0.1) : CupertinoColors.systemBackground,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.lightBackgroundGray,
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
          border: isActive ? Border.all(color: CupertinoColors.systemBlue, width: 2) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getWeekday(weather.date), style: CupertinoTheme.of(context).textTheme.textStyle),
            CachedNetworkImage(
              imageUrl: 'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
              height: 50,
              errorWidget: (context, url, error) => const Text('Weather condition image not found'),
              placeholder: (context, url) => const CupertinoActivityIndicator(),
            ),
            Text(
              '${formatTemperature(weather.minTemperature, unit)} / ${formatTemperature(weather.maxTemperature, unit)}',
              style: CupertinoTheme.of(context).textTheme.tabLabelTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
