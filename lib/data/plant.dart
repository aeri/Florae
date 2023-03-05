import 'package:objectbox/objectbox.dart';

@Entity()
class Care {
  int id = 0;
  String name;
  int cycles = 0;
  @Property(type: PropertyType.date)
  DateTime? effected;

  Care({required this.name, required this.cycles, required this.effected});

  factory Care.fromJson(Map<String, dynamic> json) => Care(
      cycles: json["cycles"], effected: json["effected"], name: json["name"]);

  Map<String, dynamic> toJson() =>
      {"cycles": cycles, "effected": effected, "name": name};
}

@Entity()
class Plant {
  int id = 0;
  String name;
  String? location;
  String description;
  @Property(type: PropertyType.date)
  DateTime createdAt;
  String? picture;

  final cares = ToMany<Care>();

  Plant(
      {required this.name,
      this.id = 0,
      this.location,
      this.description = "",
      required this.createdAt,
      this.picture});

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        name: json["name"],
        location: json["location"],
        description: json["description"],
        createdAt: json["createdAt"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "description": description,
        "createdAt": createdAt,
        "picture": picture,
      };
}
