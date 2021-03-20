class Current {
  String observationTime;
  int temperature;
  List<String> weatherIcons;
  List<String> weatherDescriptions;

  Current({
    this.observationTime,
    this.temperature,
    this.weatherIcons,
    this.weatherDescriptions,
  });

  Current.fromJson(Map<String, dynamic> json)
      : observationTime = json['observation_time'],
        temperature = json['temperature'],
        weatherIcons = json['weather_icons'].cast<String>(),
        weatherDescriptions = json['weather_descriptions'].cast<String>();

  Map<String, dynamic> toJson() => {
        'observation_time': observationTime,
        'temperature': temperature,
        'weather_icons': weatherIcons,
        'weather_descriptions': weatherDescriptions,
      };
}
