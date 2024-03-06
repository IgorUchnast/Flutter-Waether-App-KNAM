import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart';

class WeatherService {
  Future<WeatherModel> getWeatherData(String place) async {
    try {
      final queryParameters = {
        'key': apiKey,
        'q': place,
      };
      final uri =
          Uri.http("api.weatherapi.com", "/v1/current.json", queryParameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        // print(response.body);
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Error: Can't get weather");
      }
    } catch (e) {
      rethrow;
    }
  }
}

class WeatherModel {
  final double temperatureC;
  final double temperatureF;
  final String condition;
  final String conditionIcon;
  final String locationCountry;
  // final String day;

  WeatherModel({
    this.temperatureC = 0,
    this.temperatureF = 0,
    this.condition = "",
    this.conditionIcon = "//cdn.weatherapi.com/weather/64x64/day/113.png",
    this.locationCountry = "Poland",
    // this.day = "10",
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperatureC: json['current']['temp_c'],
      temperatureF: json["current"]['temp_f'],
      condition: json["current"]["condition"]["text"],
      conditionIcon: json["current"]["condition"]["icon"],
      locationCountry: json["location"]["country"],
      // day: json["forecast"]["forecastday"]["hour"]["time"],
    );
  }
}
