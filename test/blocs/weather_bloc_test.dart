import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/blocs/weather_event.dart';
import 'package:weather_app/blocs/weather_state.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late WeatherRepository repository;
  late WeatherBloc weatherBloc;

  setUp(() {
    repository = MockWeatherRepository();
    weatherBloc = WeatherBloc(repository);
  });

  tearDown(() {
    weatherBloc.close();
  });

  const testWeather = Weather(
    cityName: 'Berlin',
    forecast: [
      Forecast(
        date: '2024-12-28',
        condition: 'Sunny',
        temperature: 20.0,
        minTemperature: 18.0,
        maxTemperature: 22.0,
        currentTemperature: 21.0,
        icon: '01d',
        humidity: 50,
        pressure: 1012,
        wind: 3.5,
      ),
    ],
  );

  group('WeatherBloc', () {
    test('initial state is WeatherInitial', () {
      expect(weatherBloc.state, WeatherInitial());
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when fetchWeather succeeds',
      build: () {
        when(() => repository.fetchWeather('Berlin')).thenAnswer((_) async => testWeather);
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const FetchWeather('Berlin')),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(weather: testWeather),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherError] when fetchWeather fails',
      build: () {
        when(() => repository.fetchWeather('Berlin')).thenThrow(Exception('Failed to load weather'));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const FetchWeather('Berlin')),
      expect: () => [
        WeatherLoading(),
        WeatherError(),
      ],
    );
  });
}
