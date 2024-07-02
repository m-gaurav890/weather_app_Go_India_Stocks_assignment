import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  Map? info;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    info = ModalRoute.of(context)!.settings.arguments as Map?;
    if (info != null) {
      _setWeatherData();
    }
  }

  Future<void> _refresh() async {
    String city = info?['cityValue'] ?? 'Haldwani';
    await Navigator.pushReplacementNamed(
      context,
      '/loading',
      arguments: {'cityValue': city},
    );
  }

  void _setWeatherData() {
    setState(() {
      if (info != null) {
        String putTemp = (info!["tempValue"] as String?) ?? "NA";
        String putAirSpeed = (info!["airSpeedValue"] as String?) ?? "NA";
        String putIcon = (info!["iconValue"] as String?) ?? "09d";
        String putHumidity = (info!["humidityValue"] as String?) ?? "NA";
        String putWeatherDescription = (info!["weatherDescription"] as String?) ?? "NA";
        String putCity = (info!["cityValue"] as String?) ?? "NA";

        if (putTemp != "NA") putTemp = putTemp.substring(0, 4);
        if (putAirSpeed != "NA") putAirSpeed = putAirSpeed.substring(0, 4);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String putTemp = info?["tempValue"] ?? "NA";
    String putAirSpeed = info?["airSpeedValue"] ?? "NA";
    String putIcon = info?["iconValue"] ?? "09d";
    String putHumidity = info?["humidityValue"] ?? "NA";
    String putWeatherDescription = info?["weatherDescription"] ?? "NA";
    String putCity = info?["cityValue"] ?? "NA";

    if (putTemp != "NA") {
      putTemp = putTemp.substring(0, 4);
    }
    if (putAirSpeed != "NA") {
      putAirSpeed = putAirSpeed.substring(0, 4);
    }

    // Random city
    List<String> cityName = ["Haldwani", "Delhi", "Chennai", "Mumbai", "Goa", "Gopeshwar"];
    final _random = Random();
    String city = cityName[_random.nextInt(cityName.length)];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: GradientAppBar(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blue[300]!],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    // Search container
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black26,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (searchController.text.replaceAll(" ", "").isEmpty) {
                              print("blank search");
                            } else {
                              Navigator.pushReplacementNamed(context, "/loading", arguments: {
                                "cityValue": searchController.text,
                              });
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 20, left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.blue[400],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search $city..",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // Second container
                          height: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                  "https://openweathermap.org/img/wn/$putIcon@2x.png"),
                              const SizedBox(
                                width: 30,
                              ),
                              Column(
                                children: [
                                  Text(
                                    putWeatherDescription,
                                    style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "In $putCity",
                                    style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // Third container
                          height: 180,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(WeatherIcons.thermometer),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    putTemp,
                                    style: const TextStyle(fontSize: 70),
                                  ),
                                  const Text(
                                    "C",
                                    style: TextStyle(fontSize: 30),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // Fourth container
                          height: 200,
                          margin: const EdgeInsets.only(left: 20, right: 10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.wind_beaufort_1),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                putAirSpeed,
                                style: const TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "km/h",
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // Fifth container
                          height: 200,
                          margin: const EdgeInsets.only(right: 20, left: 10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.humidity),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                putHumidity,
                                style: const TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "percent",
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _refresh,
                    child: const Text('Refresh'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    padding: const EdgeInsets.all(30),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Made By Gaurav Joshi",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Data Provided By openweather.org",
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
