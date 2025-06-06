import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:florae/data/backup/binary.dart';
import 'package:florae/data/backup/save.dart';
import 'package:florae/main.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class BackupManager {
  static Future<bool> backup() async {
    var plants = await garden.getAllPlants();

    List<Binary> binaries = [];

    var save = Save(binaries: binaries, garden: plants);

    for (final plant in plants) {
      if (!plant.picture!.contains("assets/")) {
        File picture = File(plant.picture!);
        String base64Image = base64Encode(await picture.readAsBytes());
        binaries.add(Binary(
            id: plant.id,
            base64Data: base64Image,
            fileName: basename(picture.path)));
      }
    }

    String jsonString = jsonEncode(save);
    List<int> bytes = utf8.encode(jsonString);
    Uint8List? binaryData = Uint8List.fromList(bytes);

    String? outputFile = await FilePicker.platform.saveFile(
      fileName: 'florae-backup.json',
      bytes: binaryData,
    );

    if (outputFile == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> restore() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);

        var rawSave = jsonDecode(await file.readAsString());
        var save = Save.fromJson(rawSave);

        for (var plant in save.garden) {
          var binary = save.binaries.where((x) => x.id == plant.id);
          if (binary.isNotEmpty) {
            var picture = binary.first;

            var path = await saveBinaryToFile(
                base64Decode(picture.base64Data), picture.fileName);
            plant.picture = path;
          }

          await garden.addOrUpdatePlant(plant);
        }

        return true;
      } else {
        return false;
      }
    } catch (ex) {
      return false;
    }
  }

  static Future<String> saveBinaryToFile(
      Uint8List binaryData, String fileName) async {
    final Directory directory = await getExternalStorageDirectory() ??
        await getApplicationDocumentsDirectory();

    final path = directory.path;

    final file = File('$path/$fileName');

    await file.writeAsBytes(binaryData);

    return file.path;
  }
}
