import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import '/blocs/forecast/forecast_bloc.dart';
import '/blocs/forecast/forecast_state.dart';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/views/gradient_container.dart';

class ForecastReportScreen extends StatelessWidget {
  const ForecastReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastBloc, ForecastState>(
      builder: (context, state) {
        if (state is ForecastLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ForecastError) {
          return Center(child: Text(state.message));
        }

        if (state is ForecastLoaded) {
          return GradientContainer(
            children: [
              const Text(
                'Forecast Report',
                style: TextStyles.h1,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: state.forecast.list.length,
                  itemBuilder: (context, index) {
                    final forecast = state.forecast.list[index];
                    final time = Jiffy.parse(forecast.dtTxt)
                        .format(pattern: 'EEEE, h:mm a');

                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryBlack,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                time,
                                style: TextStyles.subtitleText,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                forecast.weather[0].description,
                                style: TextStyles.h3,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/${forecast.weather[0].icon.replaceAll('n', 'd')}.png',
                                height: 40,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                '${forecast.main.temp.round()}°',
                                style: TextStyles.h2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
