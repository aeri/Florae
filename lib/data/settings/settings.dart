import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../day_of_time_convertor.dart';

part 'settings.g.dart';

@JsonSerializable(explicitToJson: true)
class Settings {
  @DayOfTimeConvertor()
  TimeOfDay? morningNotification;
  @DayOfTimeConvertor()
  TimeOfDay? eveningNotification;
  @DayOfTimeConvertor()
  TimeOfDay? nightNotification;

  Settings({
    this.morningNotification,
    this.eveningNotification,
    this.nightNotification,
  });

  Settings.init({
    this.morningNotification = const TimeOfDay(hour: 9, minute: 0),
    this.eveningNotification = const TimeOfDay(hour: 12, minute: 0),
    this.nightNotification = const TimeOfDay(hour: 21, minute: 0),
  });

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}
