import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/weather/weather_event.dart';
import '/blocs/weather/weather_state.dart';
import '/services/api_helper.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeatherByCity>(_onGetWeatherByCity);
    on<GetWeatherByLocation>(_onGetWeatherByLocation);
  }

  Future<void> _onGetWeatherByCity(
    GetWeatherByCity event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await ApiHelper.getWeatherByCityName(
        cityName: event.cityName,
      );
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(const WeatherError('City not found'));
    }
  }

  Future<void> _onGetWeatherByLocation(
    GetWeatherByLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await ApiHelper.getCurrentWeather();
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError('Location error or network issue: $e'));
    }
  }
}
