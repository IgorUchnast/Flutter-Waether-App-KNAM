import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart';

// class WeatherForecastService {
//   Future<Map<String, dynamic>> fetchWeatherData() async {
//     try {
//       int numberOfDays = 3;
//       String location = "Warsaw";
//       String baseUrl = "https://api.weatherapi.com/v1/forecast.json";

//       String url = '$baseUrl?key=$apiKey&q=$location&days=$numberOfDays';

//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         Map<String, dynamic> weatherData = jsonDecode(response.body);

//         // Pobierz dane temperatury na najbliższe 3 dni
//         List<int> temperatures = [];
//         for (int i = 0; i < numberOfDays; i++) {
//           // Zakładam, że dane pogodowe zawierają temperaturę na każdy dzień
//           double temperature =
//               weatherData['forecast']['forecastday'][i]['day']['avgtemp_c'];
//           temperatures.add(temperature.toInt());
//         }
//         return weatherData;
//       } else {
//         throw Exception('Failed to load weather data');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }

// class WeatherForecast {
//   final double tempC;

//   WeatherForecast({
//     this.tempC = 1.0,
//   });

//   factory WeatherForecast.fromJson(Map<String, dynamic> json) {
//     return WeatherForecast(
//       tempC: json['forecast']['forecastday'][0]['day']['avgtemp_c'],
//     );
//   }
// }

class WeatherForecastService {
  Future<List<WeatherForecast>> fetchWeatherData() async {
    try {
      int numberOfDays = 3;
      String location = "Warsaw";
      String baseUrl = "https://api.weatherapi.com/v1/forecast.json";

      String url = '$baseUrl?key=$apiKey&q=$location&days=$numberOfDays';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> weatherData = jsonDecode(response.body);
        // print(weatherData["location"]);
        // List<WeatherForecast> locationData = [];
        // for (int i = 0; i < numberOfDays; i++) {
        //   locationData
        //       .add(WeatherForecast.fromJson(weatherData["location"][i]));
        // }
        // Pobierz dane pogodowe na najbliższe 3 dni
        List<WeatherForecast> forecasts = [];
        for (int i = 0; i < numberOfDays; i++) {
          // forecasts.add(locationData[i]);
          forecasts.add(WeatherForecast.fromJson(
              weatherData['forecast']['forecastday'][i]));
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
  // final String country;
  // final String city;

  WeatherForecast({
    this.tempC = 1.0,
    this.date = "",
    this.condition = "",
    this.icon = "//cdn.weatherapi.com/weather/64x64/day/113.png",
    // this.city = "Warsaw",
    // this.country = "Poland",
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      tempC: json['day']['avgtemp_c'],
      date: json['date'],
      condition: json['day']['condition']['text'],
      icon: json['day']['condition']['icon'],
      // city: json["location"]["name"],
      // country: json["location"]["country"],
    );
  }
}
