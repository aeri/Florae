import 'package:flutter/material.dart';

class DefaultValues{

  static Map<String, CareMap> cares = {};

  DefaultValues(){
    cares["water"] = CareMap(name: "water", translatedName:  "Water", description:  "Water", color: Colors.blue, icon: Icons.opacity);
    cares["spray"] = CareMap(name: "spray", translatedName:  "Spray", description:  "Spray", color: Colors.lightGreen, icon: Icons.air);
    cares["rotate"] = CareMap(name: "rotate", translatedName:  "Rotate", description:  "Rotate", color: Colors.purple, icon: Icons.rotate_90_degrees_ccw);
    cares["prune"] = CareMap(name: "prune", translatedName:  "Prune", description:  "Prune", color: Colors.orange, icon: Icons.cut);
    cares["fertilise"] = CareMap(name: "fertilise", translatedName:  "Fertilise", description:  "Fertilise", color: Colors.brown, icon: Icons.workspaces_filled);
    cares["transplant"] = CareMap(name: "transplant", translatedName:  "Transplant", description:  "Transplant", color: Colors.green, icon: Icons.compost);
    cares["clean"] = CareMap(name: "clean", translatedName:  "Clean", description:  "Clean", color: Colors.blueGrey, icon: Icons.cleaning_services);

  }

  static CareMap? getCare(String care){
    DefaultValues();
    return cares[care];
  }
  static Map<String, CareMap> getCares(){
    DefaultValues();
    return cares;
  }

}


class CareMap {
  String name;
  String translatedName;
  String description;
  MaterialColor color;
  IconData icon;

  CareMap({
    required this.name,
    required this.translatedName,
    required this.description,
    required this.color,
    required this.icon});



}