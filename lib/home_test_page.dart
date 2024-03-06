import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/service/forecast_api.dart';

class HomeTestPage extends StatefulWidget {
  const HomeTestPage({super.key});

  @override
  State<HomeTestPage> createState() => _HomeTestPageState();
}

class _HomeTestPageState extends State<HomeTestPage> {
  ForecastWeatherServices forecastWeatherServices = ForecastWeatherServices();
  late List<WeatherForecast> weatherData;
  WeatherForecast weatherForecast = WeatherForecast();

  String calendarData0 = "";
  double temperature0 = 0.0;
  String iconCondition0 = "";
  String condition0 = "";
  String city = "Warsaw";
  String country = "Poland";
  int nrOfDays = 3;

  int dayNr0 = 0;
  int dayNr1 = 1;
  int dayNr2 = 2;

  String calendarData1 = "";
  double temperature1 = 0.0;
  String iconCondition1 = "";
  String condition1 = "";

  String calendarData2 = "";
  double temperature2 = 0.0;
  String iconCondition2 = "";
  String condition2 = "";

  @override
  void initState() {
    super.initState();
    getWeatherForecast();
  }

  void getWeatherForecast() async {
    weatherData =
        await forecastWeatherServices.getWeatherForecastData(city, nrOfDays);
    setState(
      () {
        calendarData0 = weatherData[dayNr0].date;
        temperature0 = weatherData[dayNr0].tempC;
        iconCondition0 = weatherData[dayNr0].icon;
        condition0 = weatherData[dayNr0].condition;

        calendarData1 = weatherData[dayNr1].date;
        temperature1 = weatherData[dayNr1].tempC;
        iconCondition1 = weatherData[dayNr1].icon;
        condition1 = weatherData[dayNr1].condition;

        calendarData2 = weatherData[dayNr2].date;
        temperature2 = weatherData[dayNr2].tempC;
        iconCondition2 = weatherData[dayNr2].icon;
        condition2 = weatherData[dayNr2].condition;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: forecastWeatherServices.getWeatherForecastData(city, nrOfDays),
        builder: (context, AsyncSnapshot<List<WeatherForecast>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // List<WeatherForecast> weatherData = snapshot.data!;
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
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        "$temperature0",
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
                      Image.network("https:$iconCondition0"),
                      Text(
                        condition0,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    height: 100,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    height: 450,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Title(
                          color: Colors.white,
                          child: const Text(
                            "Prognoza pogody (3 dni)",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        RowForecast(
                          calendarData: calendarData0,
                          iconData: iconCondition0,
                          temperature: temperature0,
                        ),
                        RowForecast(
                          calendarData: calendarData1,
                          iconData: iconCondition1,
                          temperature: temperature1,
                        ),
                        RowForecast(
                          calendarData: calendarData2,
                          iconData: iconCondition2,
                          temperature: temperature2,
                        ),
                      ],
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

class RowForecast extends StatefulWidget {
  const RowForecast({
    super.key,
    required this.calendarData,
    required this.iconData,
    required this.temperature,
  });

  final String calendarData;
  final String iconData;
  final double temperature;

  @override
  State<RowForecast> createState() => _RowForecastState();
}

class _RowForecastState extends State<RowForecast> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          widget.calendarData,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        Image.network("https:${widget.iconData}"),
        Text(
          "${widget.temperature}℃",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
