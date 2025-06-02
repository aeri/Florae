// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Binary _$BinaryFromJson(Map<String, dynamic> json) => Binary(
      id: json['id'] as int,
      base64Data: json['base64Data'] as String,
      fileName: json['fileName'] as String,
    );

Map<String, dynamic> _$BinaryToJson(Binary instance) => <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'base64Data': instance.base64Data,
    };
