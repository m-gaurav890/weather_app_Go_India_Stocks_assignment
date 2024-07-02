import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Worker/worker.dart';

class LoadingActivity extends StatefulWidget {
  const LoadingActivity({super.key});

  @override
  State<LoadingActivity> createState() => _LoadingActivityState();
}
String city="Haldwani";
class _LoadingActivityState extends State<LoadingActivity> {
  String? throwTemp;
  String? throwHumidity;
  String? throwAirSpeed;
  String? throwWeatherDescription;
  String? throwMain;
  String? throwIcon;

  void startApp(String city) async {
    Worker instance = Worker(location: city);
    await instance.getData();
    throwTemp = instance.temp;
    throwHumidity = instance.humidity;
    throwAirSpeed = instance.airSpeed;
    throwWeatherDescription = instance.weatherDescription;
    throwMain = instance.main;
    throwIcon = instance.icon;
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "tempValue": throwTemp,
        "humidityValue": throwHumidity,
        "airSpeedValue": throwAirSpeed,
        "weatherDescription": throwWeatherDescription,
        "mainValue": throwMain,
        "iconValue": throwIcon,
        "cityValue": city
      });
    });

  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? cityName=ModalRoute.of(context)!.settings.arguments as Map?;

    if(cityName?.isNotEmpty ?? false){
      city=cityName!["cityValue"];
    }
    startApp(city);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 300,
              width: 300,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Weather App",
              style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Made By Gaurav Joshi",
              style: TextStyle(fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 100,
            ),
            const SpinKitWave(
              color: Colors.cyan,
              size: 50.0,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue[700],
    );
  }
}
