import 'dart:convert';

LocationModel LocationModelFromJson(String str) => LocationModel.fromJson(json.decode(str));

String LocationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel{
  Location location;
  Current current;

  LocationModel({required this.location, required this.current});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(location: Location.fromJson(json["location"]), current:Current.fromJson(json["current"]) );

  Map<String, dynamic> toJson() => {
    "location": location,
    "current": current
  };
}

class Location{
  String name;

  Location({required this.name});

  factory Location.fromJson(Map<String, dynamic> json) => Location(name: json["name"]);

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class Current{
  Condition condition;
  double temp_c;

  Current({required this.condition, required this.temp_c});

  factory Current.fromJson(Map<String, dynamic> json) => Current(condition: Condition.fromJson(json["condition"]), temp_c: json["temp_c"]);

  Map<String, dynamic> toJson() => {
    "condition": condition,
    "temp_c" : temp_c
  };
}

class Condition{
  String text;

  Condition({required this.text});

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(text: json["text"]);

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}

