import '/models/hourly_weather.dart';

abstract class ForecastState {
  const ForecastState();

  @override
  List<Object?> get props => [];
}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastLoaded extends ForecastState {
  final HourlyWeather forecast;

  const ForecastLoaded(this.forecast);

  @override
  List<Object?> get props => [forecast];
}

class ForecastError extends ForecastState {
  final String message;

  const ForecastError(this.message);

  @override
  List<Object?> get props => [message];
}
