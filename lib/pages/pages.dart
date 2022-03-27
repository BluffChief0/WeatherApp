import 'package:blockcubit/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:blockcubit/data/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class CityInputField extends StatelessWidget {
  const CityInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Enter a city',
          hintStyle: TextStyle(
            color: Colors.red[100],
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon:  Icon(Icons.search,
            color: Colors.red[100],
          ),
          suffixIconColor: Colors.red[100],
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityname) {
    final weatherBloc=context.read<WeatherBloc>();
    weatherBloc.add(GetWeather(cityname));
  }
}

Widget buildInitialInput() {
  return const Center(
    child: CityInputField(),
  );
}

Widget buildLoading() {
  return const Center(
    child: SpinKitWave(
      color: Colors.indigo,
      size: 80,
    ),
  );
}

Column buildColumnWithData(Weather weather) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        color: Colors.blueAccent,
        child: Text(
          weather.cityname,
          style:  TextStyle(
            fontSize: 50,
            fontStyle: FontStyle.italic,
            color: Colors.red[100]
          ),
        ),
      ),
      Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        color: Colors.blueAccent,
        child: Text(
          // Display the temperature with 1 decimal place
          "${weather.temperature.toStringAsFixed(1)}°C",
          style:  TextStyle(
              fontSize: 50,
              color: Colors.red[100],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 150,
              child: Card(
                color: Colors.blueAccent,
                elevation: 5,
                child: Text('Feels like: ${weather.feels_like.toStringAsFixed(1)}°C',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red[100],
                ),),
              ),
            ),
            SizedBox(width: 20,),
            Card(
              color: Colors.blueAccent,
              elevation: 5,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/${weather.osadki}.png'),
              )
            )
          ],
        ),
      ),
      const CityInputField(),
    ],
  );
}

class WeatherSearchPage extends StatefulWidget {
  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[400],
      appBar: AppBar(
        title:  Text("Weather Search",
          style: TextStyle(
            color: Colors.red[100],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[400],
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is WeatherInitial) {
              return buildInitialInput();
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(state.weather);
            } else {
              // (state is WeatherError)
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }
}





