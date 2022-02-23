import 'package:florae/plant_database_implementation.dart';
import 'package:florae/plant_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class Init {
  static Future initialize() async {
    await _initSembast();
    _registerRepositories();

  }

  static Future _initSembast() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "plants.db");
    final database = await databaseFactoryIo.openDatabase(databasePath);
    GetIt.I.registerSingleton<Database>(database);
  }
  static _registerRepositories(){
    GetIt.I.registerLazySingleton<PlantRepository>(() => SembastPlantRepository());
  }

}
