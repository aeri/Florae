import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class DayOfTimeConvertor implements JsonConverter<TimeOfDay?, String?> {
  const DayOfTimeConvertor();

  @override
  TimeOfDay? fromJson(String? json) {
    if (json == null) return null;
    final parts = json.split(":");
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  String? toJson(TimeOfDay? dayOfTime) {
    if (dayOfTime == null) return null;
    return '${dayOfTime.hour}:${dayOfTime.minute}';
  }
}
