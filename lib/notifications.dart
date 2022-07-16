import 'package:flutter_local_notifications/flutter_local_notifications.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _startForegroundService() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.startForegroundService(1, 'plain title', 'plain body',
      notificationDetails: androidPlatformChannelSpecifics,
      payload: 'item x');
}

void _requestPermissions() {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      MacOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
}



Future<void> _createNotificationChannelGroup() async {
  const String channelGroupId = 'your channel group id';
  // create the group first
  const AndroidNotificationChannelGroup androidNotificationChannelGroup =
  AndroidNotificationChannelGroup(
      channelGroupId, 'your channel group name',
      description: 'your channel group description');
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()!
      .createNotificationChannelGroup(androidNotificationChannelGroup);

  // create channels associated with the group
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()!
      .createNotificationChannel(const AndroidNotificationChannel(
      'grouped channel id 1', 'grouped channel name 1',
      description: 'grouped channel description 1',
      groupId: channelGroupId));

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()!
      .createNotificationChannel(const AndroidNotificationChannel(
      'grouped channel id 2', 'grouped channel name 2',
      description: 'grouped channel description 2',
      groupId: channelGroupId));

}

void initNotifications () async {

  //_startForegroundService();
  //_requestPermissions();
  //_createNotificationChannelGroup();



  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@drawable/ic_stat_florae');
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);


}

Future singleNotification(String title, String body, int hashCode, {String? payload, String? sound}) async {

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('care_reminder', 'Care reminder',
      icon: '@drawable/ic_stat_florae',
      channelDescription: 'Receive plants care notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'care_reminder');

  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
      hashCode, title, body, platformChannelSpecifics,
      payload: payload);


}