import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DefaultValues {
  static Map<String, CareMap> cares = {};

  DefaultValues(BuildContext context) {
    cares["water"] = CareMap(
        name: "water",
        translatedName: AppLocalizations.of(context)!.water,
        description: "Water",
        defaultCycles: 3,
        color: Colors.blue,
        icon: Icons.opacity);
    cares["spray"] = CareMap(
        name: "spray",
        translatedName: AppLocalizations.of(context)!.spray,
        description: "Spray",
        defaultCycles: 0,
        color: Colors.lightGreen,
        icon: Icons.air);
    cares["rotate"] = CareMap(
        name: "rotate",
        translatedName: AppLocalizations.of(context)!.rotate,
        description: "Rotate",
        defaultCycles: 0,
        color: Colors.purple,
        icon: Icons.rotate_90_degrees_ccw);
    cares["prune"] = CareMap(
        name: "prune",
        translatedName: AppLocalizations.of(context)!.prune,
        description: "Prune",
        defaultCycles: 0,
        color: Colors.orange,
        icon: Icons.cut);
    cares["fertilise"] = CareMap(
        name: "fertilise",
        translatedName: AppLocalizations.of(context)!.fertilise,
        description: "Fertilise",
        defaultCycles: 0,
        color: Colors.brown,
        icon: Icons.workspaces_filled);
    cares["transplant"] = CareMap(
        name: "transplant",
        translatedName: AppLocalizations.of(context)!.transplant,
        description: "Transplant",
        defaultCycles: 0,
        color: Colors.green,
        icon: Icons.compost);
    cares["clean"] = CareMap(
        name: "clean",
        translatedName: AppLocalizations.of(context)!.clean,
        description: "Clean",
        defaultCycles: 0,
        color: Colors.blueGrey,
        icon: Icons.cleaning_services);
  }

  static CareMap? getCare(BuildContext context, String care) {
    DefaultValues(context);
    return cares[care];
  }

  static Map<String, CareMap> getCares(BuildContext context) {
    DefaultValues(context);
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
