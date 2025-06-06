import 'dart:io';

import 'package:florae/data/settings/settings_manager.dart';
import 'package:florae/notifications.dart' as notify;
import 'package:flutter/material.dart';

import 'data/care.dart';
import 'data/garden.dart';
import 'data/plant.dart';
import 'l10n/app_localizations.dart';

Future<void> checkCaresAndNotify() async {
  final settings = await SettingsManager.getSettings();
  final timeNow = TimeOfDay.now();

  if (timeNow.hour != settings.morningNotification?.hour &&
      timeNow.hour != settings.eveningNotification?.hour &&
      timeNow.hour != settings.nightNotification?.hour) {
    return;
  }

  Garden garden = await Garden.load();

  List<Plant> allPlants = await garden.getAllPlants();

  List<String> plants = [];
  String notificationTitle = "Plants require care";

  for (Plant plant in allPlants) {
    for (Care care in plant.cares) {
      // Report all unattended care, current and past
      if (care.isRequired(DateTime.now(), false)) {
        plants.add(plant.name);
        break;
      }
    }
  }

  try {
    final String locale = Platform.localeName.substring(0, 2);

    if (AppLocalizations.delegate.isSupported(Locale(locale))) {
      final t = await AppLocalizations.delegate.load(Locale(locale));
      notificationTitle = t.careNotificationTitle;
    } else {
      print("handless florae: unsupported locale " + locale);
    }
  } on Exception catch (_) {
    print("handless florae: Failed to load locale");
  }

  if (plants.isNotEmpty) {
    notify.singleNotification(notificationTitle, plants.join('\n'), 7);
    print("headless florae detected plants " + plants.join(' '));
  } else {
    print("headless florae no plants require care");
  }
}
