import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late WeatherRepository repository;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dotenv.testLoad(fileInput: 'OPEN_WEATHER_MAP_API_KEY=your_api_key_here');
    repository = WeatherRepository(client: mockHttpClient);
  });

  const cityName = 'Berlin';
  final mockResponse = json.encode({
    'city': {'name': 'Berlin'},
    'list': [
      {
        'dt_txt': '2024-12-28 12:00:00',
        'main': {'temp': 20.0, 'humidity': 50, 'pressure': 1012},
        'weather': [
          {'main': 'Sunny', 'icon': '01d'}
        ],
        'wind': {'speed': 3.5},
      }
    ]
  });

  group('WeatherRepository', () {
    test('returns Weather when the call completes successfully', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response(mockResponse, 200),
      );

      final result = await repository.fetchWeather(cityName);

      expect(result.cityName, equals('Berlin'));
      expect(result.forecast.first.temperature, equals(20.0));
    });

    test('throws Exception when the call fails', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('Error', 404),
      );

      expect(
        () async => repository.fetchWeather(cityName),
        throwsA(isA<Exception>()),
      );
    });
  });
}
