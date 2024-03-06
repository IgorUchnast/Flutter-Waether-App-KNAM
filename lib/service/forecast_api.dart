import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart';

class ForecastWeatherServices {
  Future<List<WeatherForecast>> getWeatherForecastData(
      String place, int numberOfDays) async {
    try {
      String baseUrl = "https://api.weatherapi.com/v1/forecast.json";

      String url = '$baseUrl?key=$apiKey&q=$place&days=$numberOfDays';

      final response = await http.get(Uri.parse(url));
      // final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> weatherData = jsonDecode(response.body);
        // print(
        //     "${weatherData['forecast']['forecastday'][0]['hour'][1]["temp_c"]}");
        // print(
        //     "${weatherData['forecast']['forecastday'][0]['hour'][1]["time"]}");
        List<WeatherForecast> forecasts = [];
        for (int i = 0; i < numberOfDays; i++) {
          forecasts.addAll([
            WeatherForecast.fromJson(weatherData['forecast']['forecastday'][i]),
            // WeatherForecast.fromJson(weatherData["location"])
          ]);
        }
        // print(forecasts);

        return forecasts;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class WeatherForecast {
  final double tempC;
  final String date;
  final String condition;
  final String icon;
  final double tempHour;
  final String iconHour;

  WeatherForecast({
    this.tempC = 1.0,
    this.date = "",
    this.condition = "",
    this.icon = "//cdn.weatherapi.com/weather/64x64/day/113.png",
    this.tempHour = 0.0,
    this.iconHour = "//cdn.weatherapi.com/weather/64x64/day/113.png",
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      tempC: json['day']['avgtemp_c'],
      date: json['date'],
      condition: json['day']['condition']['text'],
      icon: json['day']['condition']['icon'],
      tempHour: json['hour'][0]["temp_c"],
      iconHour: json['hour'][0]["condition"]["icon"],
    );
  }
}
