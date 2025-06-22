import 'package:background_fetch/background_fetch.dart';
import 'package:florae/screens/error.dart';
import 'package:florae/themes/darkTheme.dart';
import 'package:florae/themes/lightTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'background_task.dart';
import 'data/garden.dart';
import 'l10n/app_localizations.dart';
import 'screens/home_page.dart';

late Garden garden;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  garden = await Garden.load();

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

  await checkCaresAndNotify();

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
          Locale('nl'), // Dutch
          Locale('zh'), // Chinese (Simplified, People's Republic of China)
          Locale('ru'), // Russian
          Locale('ar'), // Arabic
        ],
        theme: buildLightThemeData(),
        darkTheme: buildDarkThemeData(),
        home: const MyHomePage(title: 'Today'));
  }
}
