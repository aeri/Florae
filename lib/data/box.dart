import 'dart:io';

import 'package:florae/data/plant.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';
import 'package:path_provider/path_provider.dart';
import '../objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  /// A Box of notes.
  late final Box<Plant> plantBox;

  late final Box<Care> careBox;

  ObjectBox._create(this.store) {
    plantBox = Box<Plant>(store);
    careBox = Box<Care>(store);
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart

    Directory? dbPath = (await getExternalStorageDirectory());

    dbPath ??= (await defaultStoreDirectory());

    Store store;

    if (Store.isOpen(dbPath.path)) {
      store = Store.attach(getObjectBoxModel(), dbPath.path);
    }
    else{
      store = await openStore(directory: dbPath.path);
    }
    return ObjectBox._create(store);
  }

  int addPlant(Plant plant) => store.box<Plant>().put(plant);

  Future<void> removePlant(Plant plant) =>
      store.runInTransactionAsync(TxMode.write, _removePlantInTx, plant.id);

  /// Note: due to [dart-lang/sdk#36983](https://github.com/dart-lang/sdk/issues/36983)
  /// not using a closure as it may capture more objects than expected.
  /// These might not be send-able to an isolate. See Store.runAsync for details.
  static void _removePlantInTx(Store store, int id) {
    // Perform ObjectBox operations that take longer than a few milliseconds
    // here. To keep it simple, this example just puts a single object.

    store.box<Plant>().remove(id);
  }
}
