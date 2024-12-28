import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherRepository {
  final http.Client client;
  final String apiKey = dotenv.env['OPEN_WEATHER_MAP_API_KEY'] ?? '';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  WeatherRepository({http.Client? client}) : client = client ?? http.Client();

  Future<Weather> fetchWeather(String city) async {
    if (apiKey.isEmpty) {
      throw Exception('API key is missing');
    }
    final response = await client.get(
      Uri.parse('$baseUrl?q=$city&units=metric&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
