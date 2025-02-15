import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherforecast/blocs/weather/weather_event.dart';
import '/blocs/weather/weather_bloc.dart';
import '/blocs/weather/weather_state.dart';
import '/cubits/temperature_unit_cubit.dart';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/extensions/datetime.dart';
import '/extensions/strings.dart';
import '/views/gradient_container.dart';
import '/views/hourly_forecast_view.dart';
import 'weather_info.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, weatherState) {
        final unit = context.watch<TemperatureUnitCubit>().state;

        if (weatherState is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (weatherState is WeatherError) {
          context.read<WeatherBloc>().add(const GetWeatherByCity("Mumbai"));
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(weatherState.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Retry logic here
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        if (weatherState is WeatherLoaded) {
          final weather = weatherState.weather;
          return GradientContainer(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: double.infinity),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('°C', style: TextStyles.h3),
                      Switch(
                        value: unit == TemperatureUnit.fahrenheit,
                        onChanged: (value) {
                          context.read<TemperatureUnitCubit>().toggleUnit();
                        },
                      ),
                      const Text('°F', style: TextStyles.h3),
                    ],
                  ),
                  // Country name text
                  Text(
                    weather.name,
                    style: TextStyles.h1,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  // Today's date
                  Text(
                    DateTime.now().dateTime,
                    style: TextStyles.subtitleText,
                  ),

                  const SizedBox(height: 30),

                  // Weather icon big
                  SizedBox(
                    height: 260,
                    child: Image.asset(
                      'assets/icons/${weather.weather[0].icon.replaceAll('n', 'd')}.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Weather description
                  Text(
                    weather.weather[0].description.capitalize,
                    style: TextStyles.h2,
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Weather info in a row
              WeatherInfo(weather: weather, unit: unit),

              const SizedBox(height: 40),

              // Today Daily Forecast
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '3 Day Forecast',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // hourly forecast
              const HourlyForecastView(),
            ],
          );
        }

        return const Center(child: Text('No weather data available'));
      },
    );
  }
}
