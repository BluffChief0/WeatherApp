import 'weather.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WeatherRepository {

  @override
  Future<Weather> fetchWeather(String cityname) async {
    try {
      Response response = await get(Uri.parse(
          'http://api.openweathermap.org/geo/1.0/direct?q=$cityname&limit=5&appid=0edfdd5cb52986017e181ec19fcdaa1d'));
      List data = jsonDecode(response.body);
      Map list = data[0];
      String lat = list['lat'].toString();
      String lon = list['lon'].toString();
      Response response_ = await get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=0edfdd5cb52986017e181ec19fcdaa1d'));
      Map temp = jsonDecode(response_.body);
      Map main = temp['main'];
      double tempa = main['temp'];
      tempa=tempa-273;
      double feels=main['feels_like'];
      feels=feels-273;
      print(feels.toStringAsFixed(1));
      List weather = temp['weather'];
      Map _weather = weather[0];
      String osadki = _weather['main'];
      return Weather(
          cityname: cityname,
          temperature: tempa,
          feels_like: feels,
          osadki: osadki,
      );
    }
    catch (e) {
      throw NetworkException();
    }
  }
}

class NetworkException implements Exception {}