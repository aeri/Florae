import 'plant.dart';

abstract class PlantRepository {

  Future<String> insertPlant(Plant plant);

  Future updatePlant(Plant plant);

  Future deletePlant(String plantName);

  Future<List<Plant>> getAllPlants();
}
