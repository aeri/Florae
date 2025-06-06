import 'dart:convert';

import 'package:florae/data/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  static Future<Settings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final rawSettings = prefs.getString('settings');

    if (rawSettings != null) {
      return Settings.fromJson(jsonDecode(rawSettings));
    } else {
      return Settings.init();
    }
  }

  static Future<bool> writeSettings(Settings settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rawSettings = jsonEncode(settings);
      await prefs.setString('settings', rawSettings);

      return true;
    } catch (ex) {
      return false;
    }
  }

  static Future<void> initializeSettings() async {
    var settings = await getSettings();
    writeSettings(settings);
  }
}
