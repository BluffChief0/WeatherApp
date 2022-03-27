import 'package:blockcubit/bloc/weather_bloc.dart';
import 'package:blockcubit/data/weather_repository.dart';
import 'package:blockcubit/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context)=> WeatherBloc(WeatherRepository()),
        child: WeatherSearchPage(),
      )
    );
  }
}




