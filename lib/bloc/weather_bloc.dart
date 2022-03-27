import 'dart:async';
import 'package:blockcubit/data/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:blockcubit/data/weather.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(WeatherInitial()) {
    on<GetWeather>(_onGetWeather);
  }

  Future<void> _onGetWeather(GetWeather event, emit) async {
    try {
      emit(WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(event.cityname);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(WeatherError(message: 'Try to enter an existing city'));
    }
  }


}