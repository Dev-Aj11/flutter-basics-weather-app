import '../services/networking.dart';
import 'package:clima/services/networking.dart';
import '../services/location.dart';

const API_KEY = 'bdb59850de7b9f857a92b23d46114f40';
const OpenWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather?';

// All network calls happen in this class
class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '${OpenWeatherMapURL}q=$cityName&appid=$API_KEY&units=metric';
    NetworkHelper networkHelper = new NetworkHelper(url);
    return await networkHelper.getData();
  }

  Future<dynamic> getWeather() async {
    // get location coordinates
    Location location = Location();
    await location.getCurrentLocation();

    // get weather for desired location
    NetworkHelper networkHelper = new NetworkHelper(
        "${OpenWeatherMapURL}lat=${location.latitude}&lon=${location.longitude}&appid=$API_KEY&units=metric");

    // return location json data
    return await networkHelper.getData();
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
