import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:florae/screens/error.dart';
import 'package:flutter/material.dart';
import 'data/box.dart';
import 'data/plant.dart';
import 'screens/home_page.dart';
import 'package:florae/notifications.dart' as notify;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  // Set default locale for background service
  final prefs = await SharedPreferences.getInstance();
  String? locale = Platform.localeName.substring(0, 2);
  await prefs.setString('locale', locale);

  runApp(const FloraeApp());

  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

/// This "Headless Task" is run when app is terminated.
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  var taskId = task.taskId;
  var timeout = task.timeout;
  if (timeout) {
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }

  print("[BackgroundFetch] Headless event received: $taskId");

  ObjectBox obx = await ObjectBox.create();

  List<Plant> allPlants = obx.plantBox.getAll();
  List<String> plants = [];
  String notificationTitle = "Plants require care";

  for (Plant p in allPlants) {
    for (Care c in p.cares) {
      var daysSinceLastCare = DateTime.now().difference(c.effected!).inDays;
      print(
          "headless florae plant ${p.name} with days since last care $daysSinceLastCare");
      // Report all unattended care, current and past
      if (daysSinceLastCare != 0 && daysSinceLastCare / c.cycles >= 1) {
        plants.add(p.name);
        break;
      }
    }
  }

  obx.store.close();

  try {
    final prefs = await SharedPreferences.getInstance();

    final String locale = prefs.getString('locale') ?? "en";

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

  print("[BackgroundFetch] Headless event finished: $taskId");

  BackgroundFetch.finish(taskId);
}

class FloraeApp extends StatelessWidget {
  const FloraeApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Florae',
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return ErrorPage(errorDetails: errorDetails);
          };

          return widget!;
          },
        supportedLocales: const [
          Locale('en'), // English
          Locale('es'), // Spanish
          Locale('fr'), // French
        ],
        theme: ThemeData(
            primaryColor: Colors.teal,
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.teal,
            fontFamily: "NotoSans",
            scaffoldBackgroundColor: Colors.grey[100]),
        home: const MyHomePage(title: 'Today'));
  }
}
