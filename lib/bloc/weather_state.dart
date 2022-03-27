part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {
  WeatherInitial();
}

class WeatherLoading extends WeatherState{
  WeatherLoading();
}

class WeatherLoaded extends WeatherState with EquatableMixin{
  late Weather weather;
  WeatherLoaded(this.weather);

  @override
  List<Object> get props {
    return [weather];}
}

class WeatherError extends WeatherState with EquatableMixin{
  String message;

  WeatherError({
    required this.message,
  });

  @override
  List<Object> get props {
    return [message];}
}

