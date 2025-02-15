
abstract class WeatherEvent{
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class GetWeatherByCity extends WeatherEvent {
  final String cityName;

  const GetWeatherByCity(this.cityName);

  @override
  List<Object?> get props => [cityName];
}

class GetWeatherByLocation extends WeatherEvent {
  final double latitude;
  final double longitude;

  const GetWeatherByLocation({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
