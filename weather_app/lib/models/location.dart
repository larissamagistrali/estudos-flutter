class Location {
  String name;
  String country;
  String region;
  String localtime;

  Location({
    this.name,
    this.country,
    this.region,
    this.localtime,
  });

  Location.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        country = json['country'],
        region = json['region'],
        localtime = json['localtime'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'country': country,
        'region': region,
        'localtime': localtime,
      };
}
