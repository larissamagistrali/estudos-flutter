import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/http/webclients/weather_webclient.dart';
import 'package:weather_app/models/weather_response.dart';

class City extends StatefulWidget {
  final String cityName;

  const City({Key key, this.cityName}) : super(key: key);

  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<City> {
  WeatherResponse _response;

  @override
  void initState() {
    super.initState();
    _loadWeather(null);
    // Timer.periodic(
    //   Duration(seconds: 3),
    //   (Timer t) => _loadWeather(t),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.cityName)),
      body: _response == null
          ? CircularProgressIndicator()
          : Column(
              children: [
                Text('Time: ${_response.current.observationTime}'),
                Text('Temperature: ${_response.current.temperature}'),
                Text(
                    'Description: ${_response.current.weatherDescriptions.first}'),
                Image.network(_response.current.weatherIcons.first),
              ],
            ),
    );
  }

  _loadWeather(Timer t) {
    WeatherWebClient()
        .fetchWeather(widget.cityName)
        .then((response) => setState(() {
              _response = response;
            }));
  }
}
