import 'dart:convert';
import 'package:http/http.dart';

class Worker {
  String? location;
  String? temp;
  String? humidity;
  String? airSpeed;
  String? weatherDescription;
  String? main;
  String? icon;

  //constructor
  Worker({this.location});

  //method

  Future<void> getData() async {
    try {
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=6628a4585972cf9e9fb50c9b4af635fc"));
      Map data = jsonDecode(response.body);

      //temperature & humidity
      Map tempData = data["main"];
      double getTemp = tempData["temp"] - 273.15;
      String getHumidity = tempData["humidity"].toString();

      //weather and description
      List weatherData = data["weather"];
      Map weatherMainData = weatherData[0];
      String getWeatherMainInfo = weatherMainData["main"];
      String getDescription = weatherMainData["description"];
      String getIcon= weatherMainData["icon"];

      //air speed
      Map airData = data["wind"];
      double getAirSpeed = airData["speed"] * 3.6;

      //assigning values

      temp = getTemp.toString();
      humidity = getHumidity;
      airSpeed = getAirSpeed.toString();
      weatherDescription = getDescription;
      main = getWeatherMainInfo;
      icon =getIcon;
    } catch (e) {
      temp = ("NA");
      humidity = "NA";
      airSpeed = "NA";
      weatherDescription = "NA";
      main = "NA";
      icon ="09d";
    }
  }
}
