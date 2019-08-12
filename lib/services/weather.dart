import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';
import 'package:clima/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location locationService = Location();
    await locationService.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$KOpenUrlWeatherMapURL?lat=${locationService.latitude}&lon=${locationService.longitude}&appid=$kApiKey&units=metric');

    var weatherData = await networkHelper.getData();

    if (locationService.longitude == null || locationService.latitude == null) {
      print('Can\'t retrieve weather status for null location');
      return null;
    }

    return weatherData;
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
