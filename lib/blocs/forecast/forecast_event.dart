
abstract class ForecastEvent  {
  const ForecastEvent();

  @override
  List<Object?> get props => [];
}

class GetForecastByCity extends ForecastEvent {
  final String cityName;

  const GetForecastByCity(this.cityName);

  @override
  List<Object?> get props => [cityName];
}

class GetForecastByLocation extends ForecastEvent {
  final double latitude;
  final double longitude;

  const GetForecastByLocation({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
