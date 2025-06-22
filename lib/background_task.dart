import 'dart:io';

import 'package:florae/data/settings/settings_manager.dart';
import 'package:florae/notifications.dart' as notify;
import 'package:flutter/material.dart';

import 'data/care.dart';
import 'data/garden.dart';
import 'data/plant.dart';
import 'l10n/app_localizations.dart';

bool _shouldTrigger(TimeOfDay? t) {
  if (t == null) {
    return false;
  }
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);

  return now.difference(dt).inMinutes.abs() <= 30;
}

Future<void> checkCaresAndNotify() async {
  final settings = await SettingsManager.getSettings();

  if (_shouldTrigger(settings.morningNotification) ||
      _shouldTrigger(settings.eveningNotification) ||
      _shouldTrigger(settings.nightNotification)) {
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
    if (plants.isNotEmpty) {
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

      notify.singleNotification(notificationTitle, plants.join('\n'), 7);
      print("headless florae detected plants " + plants.join(' '));
    } else {
      print("headless florae no plants require care");
    }
  }
}
