import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/weather/weather_bloc.dart';
import '/blocs/forecast/forecast_bloc.dart';
import '/cubits/temperature_unit_cubit.dart';
import '/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBloc()),
        BlocProvider(create: (context) => ForecastBloc()),
        BlocProvider(create: (context) => TemperatureUnitCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
