import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'repositories/weather_repository.dart';
import 'blocs/weather_bloc.dart';
import 'screens/home_screen.dart';

void main() async {
  await dotenv.load();
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  final WeatherRepository weatherRepository = WeatherRepository();

  WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(weatherRepository),
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: CupertinoColors.systemBlue,
          barBackgroundColor: CupertinoColors.systemGrey6,
          scaffoldBackgroundColor: CupertinoColors.systemBackground,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              color: CupertinoColors.black,
              fontSize: 16,
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
