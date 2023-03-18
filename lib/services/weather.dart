import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const String apiKey = '';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  NetworkHelper networkHelper = NetworkHelper();

  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    return await networkHelper.getData(url);
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocationCheckingPermissions();
    print("location.latitude = " + location.latitude.toString());
    print("location.longitude = " + location.longitude.toString());
    String url =
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=${apiKey}&units=metric';
    return await networkHelper.getData(url);
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
