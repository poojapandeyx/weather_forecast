# weather forecast App

A Flutter-based weather application that provides current weather information and forecasts. The app allows users to toggle between Celsius and Fahrenheit for temperature display and saves the user's preference using `SharedPreferences`. The application efficiently manages state using the Bloc (Business Logic Component), ensuring a seamless and responsive user experience.

## Features

- The app allows users to view weather by city name.
- Current weather information
- 3-day weather forecast
- Toggle between Celsius and Fahrenheit
- Persistent temperature unit preference
- Location-based weather updates

## Getting Started

These instructions will help you set up and run the project on your local machine for development and testing purposes.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/) with Flutter and Dart plugins
- [Git](https://git-scm.com/)

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/poojapandeyx/weather_forecast.git
   cd weather_app
   ```

2. **Install dependencies:**

   Run the following command in the project directory to install all required dependencies:

   ```bash
   flutter pub get
   ```

3. **Set up your API key:**

   - Obtain an API key from a weather service provider (e.g., OpenWeatherMap).
   - Add your API key to the project. You might need to create a file or modify an existing configuration file to include your API key.

4. **Run the app:**

   Connect a device or start an emulator, then run:

   ```bash
   flutter run
   ```

## Usage

- **Home Screen:** Displays the current weather with 3-day weather forecast and a toggle switch for temperature units.
- **Search Screen:** Allows users to search for weather information by city.

## Project Structure

- `lib/screens`: Contains the main screens of the app.
- `lib/blocs`: Contains BLoC (Business Logic Component) files for state management.
- `lib/cubits`: Contains Cubit files for managing simple state changes.
- `lib/views`: Contains reusable UI components.
- `lib/constants`: Contains constant values used throughout the app.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter](https://flutter.dev/)
- [OpenWeatherMap](https://openweathermap.org/) for weather data
