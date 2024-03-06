import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/service/api_connection.dart';
// import 'package:weather_app/test.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherService weatherService = WeatherService();
  WeatherModel weatherModel = WeatherModel();

  String currentWeather = "";
  double tempC = 0;
  double tempF = 0;
  String city = "Warsaw";
  String conditionIcon = "";
  String country = "Poland";

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async {
    weatherModel = await weatherService.getWeatherData(city);
    setState(() {
      currentWeather = weatherModel.condition;
      tempC = weatherModel.temperatureC;
      tempF = weatherModel.temperatureF;
      conditionIcon = weatherModel.conditionIcon;
      country = weatherModel.locationCountry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: weatherService.getWeatherData(city),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            weatherModel = snapshot.requireData;
            return Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: nightColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$city ($country)",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$tempC",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 120,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      const Text(
                        "℃",
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network("https:$conditionIcon"),
                      Text(
                        currentWeather,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // const Expanded(child: WFContainer(dayNr: 0)),
                  // const Expanded(child: WFContainer(dayNr: 1)),
                  // const Expanded(child: WFContainer(dayNr: 2)),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     const Text(
                  //       "Monday",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Image.network("https:$conditionIcon"),
                  //     Text(
                  //       tempC.toString(),
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     const Text(
                  //       "Tuesday",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Image.network("https:$conditionIcon"),
                  //     Text(
                  //       tempC.toString(),
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     const Text(
                  //       "Wednesday",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Image.network("https:$conditionIcon"),
                  //     Text(
                  //       tempC.toString(),
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     const Text(
                  //       "Thursday",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Image.network("https:$conditionIcon"),
                  //     Text(
                  //       tempC.toString(),
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     const Text(
                  //       "Friday",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Image.network("https:$conditionIcon"),
                  //     Text(
                  //       tempC.toString(),
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     const Text(
                  //       "Saturday",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Image.network("https:$conditionIcon"),
                  //     Text(
                  //       tempC.toString(),
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     const Text(
                  //       "Sunday",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Image.network("https:$conditionIcon"),
                  //     Text(
                  //       tempC.toString(),
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
