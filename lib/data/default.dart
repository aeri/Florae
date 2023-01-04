import 'package:flutter/material.dart';

class DefaultValues {
  static Map<String, CareMap> cares = {};

  DefaultValues() {
    cares["water"] = CareMap(
        name: "water",
        translatedName: "Water",
        description: "Water",
        defaultCycles: 3,
        color: Colors.blue,
        icon: Icons.opacity);
    cares["spray"] = CareMap(
        name: "spray",
        translatedName: "Spray",
        description: "Spray",
        defaultCycles: 0,
        color: Colors.lightGreen,
        icon: Icons.air);
    cares["rotate"] = CareMap(
        name: "rotate",
        translatedName: "Rotate",
        description: "Rotate",
        defaultCycles: 0,
        color: Colors.purple,
        icon: Icons.rotate_90_degrees_ccw);
    cares["prune"] = CareMap(
        name: "prune",
        translatedName: "Prune",
        description: "Prune",
        defaultCycles: 0,
        color: Colors.orange,
        icon: Icons.cut);
    cares["fertilise"] = CareMap(
        name: "fertilise",
        translatedName: "Fertilise",
        description: "Fertilise",
        defaultCycles: 0,
        color: Colors.brown,
        icon: Icons.workspaces_filled);
    cares["transplant"] = CareMap(
        name: "transplant",
        translatedName: "Transplant",
        description: "Transplant",
        defaultCycles: 0,
        color: Colors.green,
        icon: Icons.compost);
    cares["clean"] = CareMap(
        name: "clean",
        translatedName: "Clean",
        description: "Clean",
        defaultCycles: 0,
        color: Colors.blueGrey,
        icon: Icons.cleaning_services);
  }

  static CareMap? getCare(String care) {
    DefaultValues();
    return cares[care];
  }

  static Map<String, CareMap> getCares() {
    DefaultValues();
    return cares;
  }
}

class CareMap {
  String name;
  String translatedName;
  String description;
  int defaultCycles;
  MaterialColor color;
  IconData icon;

  CareMap(
      {required this.name,
      required this.translatedName,
      required this.description,
      required this.defaultCycles,
      required this.color,
      required this.icon});
}
