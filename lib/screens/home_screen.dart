import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/forecast/forecast_bloc.dart';
import '../blocs/forecast/forecast_event.dart';
import '/blocs/weather/weather_bloc.dart';
import '/blocs/weather/weather_event.dart';
import '/services/getlocator.dart';

import '/constants/app_colors.dart';
import '/screens/search_screen.dart';
import '/screens/weather_screen/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  final _screens = const [
    WeatherScreen(),
    SearchScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await GetLocator.determinePosition();
    final prefs = await SharedPreferences.getInstance();
    final lastSearchedCity = prefs.getString('lastSearchedCity');
    if (lastSearchedCity != null) {
      context.read<WeatherBloc>().add(GetWeatherByCity(lastSearchedCity));
      context.read<ForecastBloc>().add(GetForecastByCity(lastSearchedCity));
    } else {
      context.read<WeatherBloc>().add(
            GetWeatherByLocation(
              latitude: position.latitude,
              longitude: position.longitude,
            ),
          );
      context.read<ForecastBloc>().add(
            GetForecastByLocation(
              latitude: position.latitude,
              longitude: position.longitude,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
            backgroundColor: AppColors.secondaryBlack, height: 56),
        child: NavigationBar(
          selectedIndex: _currentPageIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (index) =>
              setState(() => _currentPageIndex = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Colors.white),
              selectedIcon: Icon(Icons.home, color: Colors.white),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined, color: Colors.white),
              selectedIcon: Icon(Icons.search, color: Colors.white),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
