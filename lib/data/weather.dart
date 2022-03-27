import 'package:equatable/equatable.dart';


class Weather extends Equatable{
  late String cityname;
  late double temperature;
  late double feels_like;
  late String osadki;

//<editor-fold desc="Data Methods">

  Weather({
    required this.cityname,
    required this.temperature,
    required this.feels_like,
    required this.osadki
  });

  @override
  List<Object> get props => [cityname];

}