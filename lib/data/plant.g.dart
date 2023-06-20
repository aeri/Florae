// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plant _$PlantFromJson(Map<String, dynamic> json) => Plant(
      name: json['name'] as String,
      id: json['id'] as int? ?? 0,
      location: json['location'] as String?,
      description: json['description'] as String? ?? "",
      createdAt: DateTime.parse(json['createdAt'] as String),
      picture: json['picture'] as String?,
      cares: (json['cares'] as List<dynamic>)
          .map((e) => Care.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlantToJson(Plant instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'picture': instance.picture,
      'cares': instance.cares.map((e) => e.toJson()).toList(),
    };
