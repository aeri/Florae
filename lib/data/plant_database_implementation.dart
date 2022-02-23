import 'package:florae/data/plant.dart';
import 'package:florae/data/plant_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

class SembastPlantRepository extends PlantRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = stringMapStoreFactory.store("plant_store");

  @override
  Future<String> insertPlant(Plant plant) async {
    return await _store.record(plant.name).add(_database, plant.toJson());
  }

  @override
  Future updatePlant(Plant plant) async {
    await _store.record(plant.name).update(_database, plant.toJson());
  }

  @override
  Future deletePlant(String plantName) async{
    return await _store.record(plantName).delete(_database);
  }

  @override
  Future<List<Plant>> getAllPlants() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Plant.fromJson(snapshot.value))
        .toList(growable: false);
  }
}
