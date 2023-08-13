// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Care _$CareFromJson(Map<String, dynamic> json) => Care(
      name: json['name'] as String,
      cycles: json['cycles'] as int,
      effected: json['effected'] == null
          ? null
          : DateTime.parse(json['effected'] as String),
      id: json['id'] as int,
    );

Map<String, dynamic> _$CareToJson(Care instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cycles': instance.cycles,
      'effected': instance.effected?.toIso8601String(),
    };
