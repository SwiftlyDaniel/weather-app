import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather_bloc.dart';
import '../blocs/weather_event.dart';
import '../blocs/weather_state.dart';
import '../models/forecast.dart';
import '../utils/temperature.dart';
import '../widgets/weather_detail.dart';
import '../widgets/weather_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Forecast? selectedWeather;
  TemperatureUnit _selectedUnit = TemperatureUnit.celsius;

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchWeather('Berlin'));
  }

  void _toggleTemperatureUnit(TemperatureUnit unit) {
    setState(() {
      _selectedUnit = unit;
    });
  }

  void _showTemperatureUnitSelector(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select Temperature Unit'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              _toggleTemperatureUnit(TemperatureUnit.celsius);
              Navigator.pop(context);
            },
            child: const Text('Celsius'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              _toggleTemperatureUnit(TemperatureUnit.fahrenheit);
              Navigator.pop(context);
            },
            child: const Text('Fahrenheit'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Berlin'),
        trailing: GestureDetector(
          onTap: () => _showTemperatureUnitSelector(context),
          child: const Icon(
            CupertinoIcons.thermometer,
            size: 28,
          ),
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is WeatherLoaded) {
              selectedWeather ??= state.weather.forecast.first;
              final isCurrentDay = selectedWeather == state.weather.forecast.first;
              return Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        CupertinoSliverRefreshControl(
                          onRefresh: () async {
                            context.read<WeatherBloc>().add(const FetchWeather('Berlin'));
                          },
                        ),
                        SliverToBoxAdapter(
                          child: WeatherDetail(
                            weather: selectedWeather!,
                            isCurrentDay: isCurrentDay,
                            unit: _selectedUnit,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(16),
                      itemCount: state.weather.forecast.length,
                      itemBuilder: (context, index) {
                        final dayWeather = state.weather.forecast[index];
                        return WeatherListItem(
                          weather: dayWeather,
                          isActive: dayWeather == selectedWeather,
                          onTap: () {
                            setState(() {
                              selectedWeather = dayWeather;
                            });
                          },
                          unit: _selectedUnit,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Failed to load weather'),
                    CupertinoButton(
                      onPressed: () {
                        context.read<WeatherBloc>().add(const FetchWeather('Berlin'));
                      },
                      child: const Text('Retry'),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
