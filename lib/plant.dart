import 'package:sembast/timestamp.dart';

class Plant {
  String name;
  String? location;
  String description;
  int intensity;
  Timestamp createdAt;

  Plant({
    required this.name,
    this.location,
    this.description = "",
    this.intensity = 0,
    required this.createdAt,
  });

  factory Plant.fromJson(Map<String, dynamic> json) =>
      Plant(
          name: json["name"],
          location: json["location"],
          description: json["description"],
          intensity: json["intensity"],
          createdAt: json["createdAt"]
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "location": location,
        "description": description,
        "intensity": intensity,
        "createdAt": createdAt
      };
}