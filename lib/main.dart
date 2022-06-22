import 'package:flutter/material.dart';
import 'data/box.dart';
import 'screens/home_page.dart';


late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();
  

  runApp(FloraeApp());
}

class FloraeApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Florae',
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
      home:  const MyHomePage(title: 'Today')
    );
  }
}
