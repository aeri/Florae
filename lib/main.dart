import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'data/app_databse.dart';
import 'screens/home_page.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(FloraeApp());
}

class FloraeApp extends StatelessWidget {

  final Future _init =  Init.initialize();

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
        primarySwatch: Colors.blue,
        fontFamily: "NotoSans",
        scaffoldBackgroundColor: Colors.grey[100]
      ),
      home: FutureBuilder(
        future: _init,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            return const MyHomePage(title: 'Today');
          } else {
            return Material(
              child: Center(
                child: CircularProgressIndicator(color: Colors.teal),
              ),
            );
          }
        },
      ),
    );
  }
}

