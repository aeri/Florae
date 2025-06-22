// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      morningNotification: const DayOfTimeConvertor()
          .fromJson(json['morningNotification'] as String?),
      eveningNotification: const DayOfTimeConvertor()
          .fromJson(json['eveningNotification'] as String?),
      nightNotification: const DayOfTimeConvertor()
          .fromJson(json['nightNotification'] as String?),
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'morningNotification':
          const DayOfTimeConvertor().toJson(instance.morningNotification),
      'eveningNotification':
          const DayOfTimeConvertor().toJson(instance.eveningNotification),
      'nightNotification':
          const DayOfTimeConvertor().toJson(instance.nightNotification),
    };
