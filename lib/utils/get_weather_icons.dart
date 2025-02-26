String getWeatherIcon({
  required int weatherCode,
}) {
  String weatherCondition = '01d';

  if (weatherCode == 801) {
    weatherCondition = 'assets/icons/02d.png';
  } else if (weatherCode == 802) {
    weatherCondition = 'assets/icons/03d.png';
  } else if (weatherCode == 803) {
    weatherCondition = 'assets/icons/04d.png';
  } else if (weatherCode == 804) {
    weatherCondition = 'assets/icons/04d.png';
  } else if (weatherCode == 800) {
    weatherCondition = 'assets/icons/01d.png';
  } else if (weatherCode > 700) {
    weatherCondition = 'assets/icons/50d.png';
  } else if (weatherCode >= 600) {
    weatherCondition = 'assets/icons/13d.png';
  } else if (weatherCode >= 500) {
    weatherCondition = 'assets/icons/10d.png';
  } else if (weatherCode >= 300) {
    weatherCondition = 'assets/icons/09d.png';
  } else if (weatherCode >= 200) {
    weatherCondition = 'assets/icons/11d.png';
  }

  return weatherCondition;
}

//mapping asset icons as per api icon
String getWeatherIcon2(int id) {
  if (id == 0) {
    return 'assets/icons/01d.png';
  }
  if (id == 1) {
    return 'assets/icons/6.png';
  }
  if (id == 2) {
    return 'assets/icons/03d.png';
  }
  if (id == 3) {
    return 'assets/icons/04d.png';
  }
  if (id == 45) {
    return 'assets/icons/04d.png';
  }
  if (id == 48) {
    return 'assets/icons/04d.png';
  }
  if (id == 53) {
    return 'assets/icons/39.png';
  }
  if (id > 50 && id < 60) {
    return 'assets/icons/09d.png';
  }
  if (id > 60 && id < 70) {
    return 'assets/icons/7.png';
  }
  if (id >= 70 && id < 80) {
    return 'assets/icons/04d';
  }
  if (id >= 80 && id < 85) {
    return 'assets/icons/7.png';
  }
  if (id > 85) {
    return 'assets/icons/13d.png';
  }

  return 'assets/icons/01d.png';
}

