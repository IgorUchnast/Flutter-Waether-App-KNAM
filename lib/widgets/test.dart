// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:weather_app/service/api_forecast.dart';

// class WeatherApp extends StatefulWidget {
//   @override
//   _WeatherAppState createState() => _WeatherAppState();
// }

// class _WeatherAppState extends State<WeatherApp> {
//   String apiKey = "08e3227a0e0041bfa5c174417230811";
//   String baseUrl = 'https://api.weatherapi.com/v1/forecast.json';
//   String location = 'Warsaw';
//   int numberOfDays = 3;

//   Future<Map<String, dynamic>> fetchWeatherData() async {
//     String url = '$baseUrl?key=$apiKey&q=$location&days=$numberOfDays';

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load weather data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: fetchWeatherData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             Map<String, dynamic>? weatherData = snapshot.data;
//             // print(weatherData);

//             // Pobierz dane temperatury na najbliższe 3 dni
//             List<int> temperatures = [];
//             for (int i = 0; i < numberOfDays; i++) {
//               // Zakładam, że dane pogodowe zawierają temperaturę na każdy dzień
//               double temperature = weatherData?['forecast']['forecastday'][i]
//                   ['day']['avgtemp_c'];
//               temperatures.add(temperature.toInt());
//             }
//             return Container(
//               padding: const EdgeInsets.only(top: 70),
//               color: Colors.blue,
//               width: double.infinity,
//               child: Column(
//                 children: [
//                   const Text("Temperature for the next 3 days:"),
//                   for (int i = 0; i < numberOfDays; i++)
//                     Text("Day ${i + 1}: ${temperatures[i]}°C"),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// class Test1 extends StatefulWidget {
//   const Test1({Key? key}) : super(key: key);

//   @override
//   _Test1State createState() => _Test1State();
// }

// class _Test1State extends State<Test1> {
//   WeatherForecastService weatherForecastService = WeatherForecastService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: WeatherForecastService().fetchWeatherData(),
//         builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             Map<String, dynamic>? weatherData = snapshot.data;
//             // print(weatherData);
//             // Now you can use weatherData to display the information in your UI
//             // For example, access the temperature: weatherData['forecast']['forecastday'][0]['day']['avgtemp_c']

//             return Container(
//               color: Colors.blue,
//               child: Column(
//                 children: [
//                   Text(
//                     "Temperature: ${weatherData!['forecast']['forecastday'][2]['day']['avgtemp_c']}°C",
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

class WFContainer extends StatefulWidget {
  // const Test1({Key? key}) : super(key: key);
  const WFContainer({
    super.key,
    required this.dayNr,
  });
  final int dayNr;
  @override
  _WFContainerState createState() => _WFContainerState();
}

class _WFContainerState extends State<WFContainer> {
  WeatherForecastService weatherForecastService = WeatherForecastService();
  late List<WeatherForecast> weatherData;
  WeatherForecast weatherForecast = WeatherForecast();

  String calendarData = "";
  double temperature = 1.0;
  String icon = "https://api.weatherapi.com/v1/forecast.json";
  String city = "Warsaw";
  String country = "Poland";

  @override
  void initState() {
    super.initState();
    getWeatherForecast();
  }

  void getWeatherForecast() async {
    weatherData = await weatherForecastService.fetchWeatherData();
    setState(() {
      calendarData = weatherData[widget.dayNr].date;
      temperature = weatherData[widget.dayNr].tempC;
      icon = weatherData[widget.dayNr].icon;
      // city = weatherData[widget.dayNr].city;
      // country = weatherData[widget.dayNr].country;
    });
    // print(city);
    // print(country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: weatherForecastService.fetchWeatherData(),
        builder: (context, AsyncSnapshot<List<WeatherForecast>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // List<WeatherForecast> weatherData = snapshot.data!;
            return Container(
              padding: const EdgeInsets.all(10),
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white12,
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    calendarData,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  // Image.network("$icon", scale: 1),
                  Image.network("https:$icon", scale: 1),
                  Text(
                    "$temperature°C",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
