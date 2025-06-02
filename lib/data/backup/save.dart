import 'package:json_annotation/json_annotation.dart';
import '../plant.dart';
import 'binary.dart';

part 'save.g.dart';

@JsonSerializable(explicitToJson: true)
class Save {
  int version = 1;
  DateTime createdAt = DateTime.now();
  List<Binary> binaries = [];
  List<Plant> garden = [];

  Save({
    required this.binaries,
    required this.garden,
  });

  factory Save.fromJson(Map<String, dynamic> json) => _$SaveFromJson(json);

  Map<String, dynamic> toJson() => _$SaveToJson(this);
}
