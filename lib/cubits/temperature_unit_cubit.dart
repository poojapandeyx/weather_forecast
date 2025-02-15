import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TemperatureUnit { celsius, fahrenheit }

class TemperatureUnitCubit extends Cubit<TemperatureUnit> {
  static const String _unitKey = 'temperature_unit';

  TemperatureUnitCubit() : super(TemperatureUnit.celsius) {
    _loadTemperatureUnit();
  }

  void toggleUnit() async {
    final newUnit = state == TemperatureUnit.celsius
        ? TemperatureUnit.fahrenheit
        : TemperatureUnit.celsius;
    emit(newUnit);
    _saveTemperatureUnit(newUnit);
  }

  Future<void> _loadTemperatureUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final unitIndex = prefs.getInt(_unitKey) ?? TemperatureUnit.celsius.index;
    emit(TemperatureUnit.values[unitIndex]);
  }

  Future<void> _saveTemperatureUnit(TemperatureUnit unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_unitKey, unit.index);
  }
}
