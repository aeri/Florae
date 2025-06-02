// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Save _$SaveFromJson(Map<String, dynamic> json) => Save(
      binaries: (json['binaries'] as List<dynamic>)
          .map((e) => Binary.fromJson(e as Map<String, dynamic>))
          .toList(),
      garden: (json['plants'] as List<dynamic>)
          .map((e) => Plant.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..version = json['version'] as int
      ..createdAt = DateTime.parse(json['createdAt'] as String);

Map<String, dynamic> _$SaveToJson(Save instance) => <String, dynamic>{
      'version': instance.version,
      'createdAt': instance.createdAt.toIso8601String(),
      'binaries': instance.binaries.map((e) => e.toJson()).toList(),
      'plants': instance.garden.map((e) => e.toJson()).toList(),
    };
