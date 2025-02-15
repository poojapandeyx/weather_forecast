import 'package:dio/dio.dart';

import '/constants/constants.dart';
import '/models/hourly_weather.dart';
import '/models/weather.dart';
import '/services/getlocator.dart';
import '/utils/logging.dart';

class ApiHelper {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';
 
  static double lat = 0.0;
  static double lon = 0.0;
  static final dio = Dio();

  //! Get lat and lon
  static Future<void> fetchLocation() async {
    final location = await GetLocator.determinePosition();
    lat = location.latitude;
    lon = location.longitude;
  }

  //* Current Weather
  static Future<Weather> getCurrentWeather() async {
    await fetchLocation();
    final url = _constructWeatherUrl();
    final response = await _fetchData(url);
    return Weather.fromJson(response);
  }

  //* Hourly Weather
  static Future<HourlyWeather> getHourlyForecast() async {
    await fetchLocation();
    final url = _constructForecastUrl();
    final response = await _fetchData(url);
    return HourlyWeather.fromJson(response);
  }

  //* Forecast by City Name
  static Future<HourlyWeather> getForecastByCityName({
    required String cityName,
  }) async {
    final url = _constructForecastByCityUrl(cityName);
    final response = await _fetchData(url);
    return HourlyWeather.fromJson(response);
  }

  //* Weather by City Name
  static Future<Weather> getWeatherByCityName({
    required String cityName,
  }) async {
    final url = _constructWeatherByCityUrl(cityName);
    final response = await _fetchData(url);
    return Weather.fromJson(response);
  }

  //! Build urls
  static String _constructWeatherUrl() =>
      '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructForecastUrl() =>
      '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructWeatherByCityUrl(String cityName) =>
      '$baseUrl/weather?q=$cityName&units=metric&appid=${Constants.apiKey}';

  static String _constructForecastByCityUrl(String cityName) =>
      '$baseUrl/forecast?q=$cityName&units=metric&appid=${Constants.apiKey}';

  //* Fetch Data for a url
  static Future<Map<String, dynamic>> _fetchData(String url) async {
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        printWarning('Failed to load data: ${response.statusCode}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      printWarning('Error fetching data from $url: $e');
      throw Exception('Error fetching data: $e');
    }
  }
}
