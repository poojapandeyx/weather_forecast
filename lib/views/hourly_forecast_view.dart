import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import '/blocs/forecast/forecast_bloc.dart';
import '/blocs/forecast/forecast_state.dart';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/cubits/temperature_unit_cubit.dart';

class HourlyForecastView extends StatelessWidget {
  const HourlyForecastView({super.key});

  @override
  Widget build(BuildContext context) {
    final unit = context.watch<TemperatureUnitCubit>().state;

    return BlocBuilder<ForecastBloc, ForecastState>(
      builder: (context, state) {
        if (state is ForecastLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ForecastError) {
          return Center(child: Text(state.message));
        }

        if (state is ForecastLoaded) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.forecast.list.length,
              itemBuilder: (context, index) {
                final hourlyData = state.forecast.list[index];
                final forecastDate = Jiffy.parse(hourlyData.dtTxt);
                final currentDate = Jiffy.now();
                final differenceInDays =
                    forecastDate.diff(currentDate, unit: Unit.day);
                //Because according to requirements we need to show only next 3 days forecast.
                if (differenceInDays >= 0 && differenceInDays < 3) {
                  final time = forecastDate.format(pattern: 'd MMM h a');

                  final temperature = unit == TemperatureUnit.celsius
                      ? hourlyData.main.temp
                      : (hourlyData.main.temp * 9 / 5) + 32;

                  return Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.all(15),
                    //  width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBlack,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          time,
                          style: TextStyles.subtitleText,
                        ),
                        Image.asset(
                          'assets/icons/${hourlyData.weather[0].icon.replaceAll('n', 'd')}.png',
                          height: 40,
                        ),
                        Text(
                          '${temperature.round()}° ${unit == TemperatureUnit.celsius ? 'C' : 'F'}',
                          style: TextStyles.h3,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox
                      .shrink(); // Skip items not in the next 3 days
                }
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
