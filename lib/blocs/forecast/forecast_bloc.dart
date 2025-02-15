import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/forecast/forecast_event.dart';
import '/blocs/forecast/forecast_state.dart';
import '/services/api_helper.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc() : super(ForecastInitial()) {
    on<GetForecastByCity>(_onGetForecastByCity);
    on<GetForecastByLocation>(_onGetForecastByLocation);
  }

  Future<void> _onGetForecastByCity(
    GetForecastByCity event,
    Emitter<ForecastState> emit,
  ) async {
    emit(ForecastLoading());
    try {
      final forecast = await ApiHelper.getForecastByCityName(
        cityName: event.cityName,
      );
      emit(ForecastLoaded(forecast));
    } catch (e) {
      emit(ForecastError(e.toString()));
    }
  }

  Future<void> _onGetForecastByLocation(
    GetForecastByLocation event,
    Emitter<ForecastState> emit,
  ) async {
    emit(ForecastLoading());
    try {
      ApiHelper.lat = event.latitude;
      ApiHelper.lon = event.longitude;
      final forecast = await ApiHelper.getHourlyForecast();
      emit(ForecastLoaded(forecast));
    } catch (e) {
      emit(ForecastError(e.toString()));
    }
  }
}
