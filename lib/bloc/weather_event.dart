part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeather extends WeatherEvent{
  late String cityname;

  GetWeather(this.cityname);
}