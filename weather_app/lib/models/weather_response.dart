import "current.dart";
import "location.dart";

class WeatherResponse {
  Location location;
  Current current;

  WeatherResponse({
    this.location,
    this.current,
  });

  WeatherResponse.fromJson(Map<String, dynamic> json)
      : location = Location.fromJson(json['location']),
        current = Current.fromJson(json['current']);

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'current': current.toJson(),
      };
}
