import 'dart:convert';

import 'package:weather_app/http/webclient.dart';
import 'package:weather_app/models/weather_response.dart';

class WeatherWebClient {
  Future<WeatherResponse> fetchWeather(String cityName) async {
    final uri = Uri.http(baseUrl, 'current', {
      "access_key": apiKey,
      "query": cityName,
    });
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
