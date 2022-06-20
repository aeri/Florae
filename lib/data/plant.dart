import 'package:sembast/timestamp.dart';

class Care {
  int cycles = 0;
  Timestamp? effected;

  Care({required this.cycles, required this.effected});

  factory Care.fromJson(Map<String, dynamic> json) =>
      Care(
          cycles: json["cycles"],
          effected: json["effected"]
      );

  Map<String, dynamic> toJson() =>
      {
        "cycles": cycles,
        "effected": effected
      };

}

class Plant {
  String name;
  String? location;
  String description;
  Timestamp createdAt;
  String? picture;
  Map <String, Care> cares;

  Plant({
    required this.name,
    this.location,
    this.description = "",
    required this.createdAt,
    this.picture,
    required this.cares
  });

  factory Plant.fromJson(Map<String, dynamic> json) =>
      Plant(
          name: json["name"],
          location: json["location"],
          description: json["description"],
          createdAt: json["createdAt"],
          picture: json["picture"],
          cares: json["cares"]
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "location": location,
        "description": description,
        "createdAt": createdAt,
        "picture": picture,
        "cares": cares
      };
}