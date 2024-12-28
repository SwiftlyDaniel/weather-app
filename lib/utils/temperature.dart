enum TemperatureUnit { celsius, fahrenheit }

String formatTemperature(double temperature, TemperatureUnit unit) {
  if (unit == TemperatureUnit.fahrenheit) {
    return '${(temperature * 9 / 5 + 32).toStringAsFixed(1)}°F';
  }
  return '${temperature.toStringAsFixed(1)}°C';
}
