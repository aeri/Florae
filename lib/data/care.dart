import 'package:json_annotation/json_annotation.dart';

part 'care.g.dart';

@JsonSerializable()
class Care {
  int id = 0;
  String name;
  int cycles = 0;
  DateTime? effected;

  Care(
      {required this.name,
      required this.cycles,
      required this.effected,
      required this.id});

  factory Care.fromJson(Map<String, dynamic> json) => _$CareFromJson(json);

  Map<String, dynamic> toJson() => _$CareToJson(this);
}
