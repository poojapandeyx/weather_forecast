import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/forecast/forecast_bloc.dart';
import '../blocs/forecast/forecast_event.dart';
import '../blocs/weather/weather_state.dart';
import '/blocs/weather/weather_bloc.dart';
import '/blocs/weather/weather_event.dart';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/views/gradient_container.dart';
import '/widgets/round_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              'Search City',
              style: TextStyles.h1,
            ),
            const SizedBox(height: 20),
            SearchBar(
              backgroundColor:
                  MaterialStateProperty.all(AppColors.secondaryBlack),
              hintText: 'Search for a city...',
              hintStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.grey),
              ),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<WeatherBloc>().add(GetWeatherByCity(value));
                }
              },
              // onChanged: (value) {
              //   if (value.isNotEmpty) {
              //     context.read<WeatherBloc>().add(GetWeatherByCity(value));
              //   }
              // },
            ),
            const SizedBox(height: 20),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoaded) {
                  _storeCityName(state.weather.name);
                  context
                      .read<ForecastBloc>()
                      .add(GetForecastByCity(state.weather.name));
                  return Text(
                    'Selected City: ${state.weather.name}',
                    style: TextStyles.h2,
                  );
                } else if (state is WeatherLoading) {
                  return const SizedBox(
                      height: 150,
                      child: Center(child: CircularProgressIndicator()));
                } else if (state is WeatherError) {
                  return Text(
                    'Error: ${state.message}',
                    style: TextStyles.subtitleText,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _storeCityName(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', cityName);
  }
}

class LocationIcon extends StatelessWidget {
  const LocationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: AppColors.accentBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.location_on_outlined,
        color: AppColors.grey,
      ),
    );
  }
}
