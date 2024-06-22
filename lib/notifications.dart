import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:async';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void _requestPermissions() {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}

Future<void> _createNotificationChannel(
    String channelId, String channelName, String channelDescription) async {
  AndroidNotificationChannel androidNotificationChannel =
      AndroidNotificationChannel(
    channelId,
    channelName,
    description: channelDescription,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);
}

void initNotifications(String channelName, String channelDescription) async {
  _requestPermissions();
  _createNotificationChannel("care_reminder", channelName, channelDescription);

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/ic_stat_florae');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future singleNotification(String title, String body, int hashCode,
    {String? payload, String? sound}) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('care_reminder', 'Care reminder',
          icon: '@drawable/ic_stat_florae',
          channelDescription: 'Receive plants care notifications',
          importance: Importance.max,
          priority: Priority.high,
          ticker: title);

  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin
      .show(hashCode, title, body, platformChannelSpecifics, payload: payload);
}
