import 'dart:convert';
import 'package:florae/data/plant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Garden {
  late final SharedPreferences store;

  Garden(this.store);

  static Future<Garden> load() async {
    var store = await SharedPreferences.getInstance();

    await store.reload();

    return (Garden(store));
  }

  Future<List<Plant>> getAllPlants() async {
    List<Plant> allPlants = [];
    var rawPlants = store.getString("plants");
    if (rawPlants != null) {
      Iterable l = json.decode(rawPlants);
      allPlants = List<Plant>.from(l.map((model) => Plant.fromJson(model)));
    }
    return allPlants;
  }

  // Returns true if update
  // Return false if create
  Future<bool> addOrUpdatePlant(Plant plant) async {
    List<Plant> allPlants = await getAllPlants();
    bool status;

    var plantIndex = allPlants.indexWhere((element) => element.id == plant.id);
    if (plantIndex == -1) {
      allPlants.add(plant);
      status = false;
    } else {
      allPlants[plantIndex] = plant;
      status = true;
    }
    String jsonPlants = jsonEncode(allPlants);
    await store.setString("plants", jsonPlants);

    return status;
  }

  Future<bool> deletePlant(Plant plant) async {
    List<Plant> allPlants = await getAllPlants();

    var plantIndex = allPlants.indexWhere((element) => element.id == plant.id);
    if (plantIndex != -1) {
      allPlants.removeAt(plantIndex);

      String jsonPlants = jsonEncode(allPlants);
      await store.setString("plants", jsonPlants);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePlant(Plant plant) async {
    List<Plant> allPlants = await getAllPlants();

    var plantIndex = allPlants.indexWhere((element) => element.id == plant.id);
    if (plantIndex != -1) {
      allPlants[plantIndex] = plant;

      String jsonPlants = jsonEncode(allPlants);
      await store.setString("plants", jsonPlants);
      return true;
    } else {
      return false;
    }
  }
}
