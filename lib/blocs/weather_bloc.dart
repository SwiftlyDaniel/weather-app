import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/weather_repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await repository.fetchWeather(event.city);
        emit(WeatherLoaded(weather: weather));
      } catch (e) {
        emit(WeatherError());
      }
    });
  }
}
