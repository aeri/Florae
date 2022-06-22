import 'package:florae/data/plant.dart';
import 'package:objectbox/objectbox.dart';
import '../objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  /// A Box of notes.
  late final Box<Plant> plantBox;

  ObjectBox._create(this.store) {
    plantBox = Box<Plant>(store);
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBox._create(store);
  }

  int addPlant(Plant plant) =>
      store.box<Plant>().put(plant);


}