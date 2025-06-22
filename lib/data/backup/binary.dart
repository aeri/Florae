import 'package:json_annotation/json_annotation.dart';

part 'binary.g.dart';

@JsonSerializable(explicitToJson: true)
class Binary {
  int id;
  String fileName;
  String base64Data;

  Binary({required this.id, required this.base64Data, required this.fileName});

  factory Binary.fromJson(Map<String, dynamic> json) => _$BinaryFromJson(json);

  Map<String, dynamic> toJson() => _$BinaryToJson(this);
}
