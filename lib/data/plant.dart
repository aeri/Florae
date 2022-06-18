import 'package:sembast/timestamp.dart';

class Plant {
  String name;
  String? location;
  String description;
  int cycles;
  Timestamp createdAt;
  Timestamp? watered;
  String? picture;

  Plant({
    required this.name,
    this.location,
    this.description = "",
    this.cycles = 0,
    required this.createdAt,
    this.watered,
    this.picture
  });

  factory Plant.fromJson(Map<String, dynamic> json) =>
      Plant(
          name: json["name"],
          location: json["location"],
          description: json["description"],
          cycles: json["intensity"],
          createdAt: json["createdAt"],
          watered: json["watered"],
          picture: json["picture"]
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "location": location,
        "description": description,
        "intensity": cycles,
        "createdAt": createdAt,
        "watered": watered,
        "picture": picture
      };
}