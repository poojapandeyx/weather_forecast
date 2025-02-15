import 'package:flutter/material.dart';

import '/constants/text_styles.dart';
import '/models/weather.dart';
import '/constants/app_colors.dart';
import '/cubits/temperature_unit_cubit.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;
  final TemperatureUnit unit;

  const WeatherInfo({
    super.key,
    required this.weather,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    // Convert temperature based on the unit
    final temperature = unit == TemperatureUnit.celsius
        ? weather.main.temp
        : (weather.main.temp * 9 / 5) + 32;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildWeatherInfoItem(
            '${temperature.toStringAsFixed(1)}° ${unit == TemperatureUnit.celsius ? 'C' : 'F'}',
            'Temp',
          ),
          _buildWeatherInfoItem(
            '${weather.main.humidity}%',
            'Humidity',
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfoItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyles.h2,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
