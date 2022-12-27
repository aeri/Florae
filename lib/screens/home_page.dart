import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:florae/data/plant.dart';
import 'package:florae/notifications.dart' as notify;

import 'package:intl/intl.dart';
import '../data/default.dart';
import '../data/default.dart';
import '../main.dart';
import 'manage_plant.dart';
import 'care_plant.dart';
import 'settings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Plant> _plants = [];
  Map<String, List<String>> _cares = {};
  bool _dateFilterEnabled = false;
  DateTime _dateFilter = DateTime.now();
  int _selectedIndex = 0;

  int _status = 0;

  @override
  void initState() {
    super.initState();
    _loadPlants();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    try {
      var status = await BackgroundFetch.configure(
          BackgroundFetchConfig(
              minimumFetchInterval: 15,
              forceAlarmManager: false,
              stopOnTerminate: false,
              startOnBoot: true,
              enableHeadless: true,
              requiresBatteryNotLow: false,
              requiresCharging: false,
              requiresStorageNotLow: false,
              requiresDeviceIdle: false,
              requiredNetworkType: NetworkType.NONE),
          _onBackgroundFetch,
          _onBackgroundFetchTimeout);
      print('[BackgroundFetch] configure success: $status');
      setState(() {
        _status = status;
      });
    } on Exception catch (e) {
      print("[BackgroundFetch] configure ERROR: $e");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  void _onBackgroundFetch(String taskId) async {
    // This is the fetch-event callback.
    print("[BackgroundFetch] Event received: $taskId");

    if (taskId == "flutter_background_fetch") {
      List<Plant> allPlants = objectbox.plantBox.getAll();
      List<String> plants = [];

      for (Plant p in allPlants) {
        for (Care c in p.cares) {
          var cpsr = DateTime
              .now()
              .difference(c.effected!)
              .inDays;
          if (cpsr != 0 && cpsr % c.cycles == 0) {
            plants.add(p.name);
          }
          break;
        }
      }

      if (plants.isNotEmpty) {
        notify.singleNotification("Plants require care", plants.join(' '), 7);
      }

      //notify.singleNotification("Florae", "Foreground notification", 7);

    }
    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish(taskId);
  }

  /// This event fires shortly before your task is about to timeout.  You must finish any outstanding work and call BackgroundFetch.finish(taskId).
  void _onBackgroundFetchTimeout(String taskId) {
    print("[BackgroundFetch] TIMEOUT: $taskId");
    BackgroundFetch.finish(taskId);
  }

  void _onItemTapped(int index) {
    setState(() {
      _dateFilterEnabled = false;
      _selectedIndex = index;
      _loadPlants();
    });
  }

  Future<void> _showWaterAllPlantsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Have you taken care of all the plants?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'This action will mark all plants as cared for today cycle.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                _careAllPlants();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget noPlants() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              _selectedIndex == 0
                  ? "assets/undraw_fall_thyk.svg"
                  : "assets/undraw_blooming_re_2kc4.svg",
              semanticsLabel: 'Fall',
              alignment: Alignment.center,
              height: 250,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              _selectedIndex == 0
                  ? 'Yay! You don\'t have any pending plants to care'
                  : 'The garden is empty, shall we plant something?',
              style: const TextStyle(
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Color(0x78000000),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String titleSelector() {
    if (_dateFilterEnabled) {
      return DateFormat('EEEE').format(_dateFilter) +
          " " +
          DateFormat('d').format(_dateFilter);
    } else if (_selectedIndex == 1) {
      return "Garden";
    } else {
      return "Today";
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: FittedBox(fit: BoxFit.fitWidth, child: Text(titleSelector())),
        titleTextStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            fontFamily: "NotoSans"),
        actions: <Widget>[
          _selectedIndex == 0
              ? IconButton(
            icon: const Icon(Icons.checklist_rounded),
            iconSize: 25,
            color: Colors.black54,
            tooltip: 'Apply care to all plants',
            onPressed: () {
              _showWaterAllPlantsDialog();
            },
          )
              : const SizedBox.shrink(),
          _selectedIndex == 0
              ? IconButton(
            icon: const Icon(Icons.calendar_today),
            iconSize: 25,
            color: Colors.black54,
            tooltip: 'Show Calendar',
            onPressed: () async {
              DateTime? result = await showDatePicker(
                  context: context,
                  initialDate:
                  DateTime.now().add(const Duration(days: 1)),
                  firstDate: DateTime.now().add(const Duration(days: 1)),
                  lastDate: DateTime.now().add(const Duration(days: 7)));
              setState(() {
                if (result != null) {
                  var time = TimeOfDay.now();
                  _dateFilter = result.add(
                      Duration(hours: time.hour, minutes: time.minute));
                  _dateFilterEnabled = true;
                  _loadPlants();
                }
              });
            },
          )
              : const SizedBox.shrink(),
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 25,
            color: Colors.black54,
            tooltip: 'Settings',
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) =>
                    const SettingsScreen(title: "Settings Screen"),
                  ));
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),
      body: _plants.isEmpty
          ? noPlants()
          : GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 10.0,
          children: _buildPlantCards(context) // Changed code
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: 'Garden',
          ),
        ],
        selectedItemColor: Colors.teal,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) =>
                const ManagePlantScreen(title: "Manage plant"),
              ));
          setState(() {
            _selectedIndex = 1;
            _loadPlants();
          });
        },
        tooltip: 'Add new plant',
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _loadPlants() async {
    List<Plant> plants = [];
    Map<String, List<String>> cares = {};

    List<Plant> allPlants = objectbox.plantBox.getAll();

    DateTime dateCheck = _dateFilterEnabled ? _dateFilter : DateTime.now();

    if (_selectedIndex == 0) {
      for (Plant p in allPlants) {
        cares[p.name] = [];
        for (Care c in p.cares) {
          //print((dateCheck.difference(c.effected!).inSeconds) / 60 / 60 / 24);
          var cpsr = dateCheck
              .difference(c.effected!)
              .inDays;
          if (cpsr != 0 && cpsr % c.cycles == 0) {
            plants.add(p);
            cares[p.name]!.add(c.name);
          }
        }
      }
    } else {
      plants = allPlants;
      for (Plant p in allPlants) {
        cares[p.name] = [];
        for (Care c in p.cares) {
          cares[p.name]!.add(c.name);
        }
      }
    }

    setState(() {
      _cares = cares;
      _plants = plants;
    });
  }

  _careAllPlants() async {
    List<Plant> allPlants = objectbox.plantBox.getAll();
    DateTime dateCheck = _dateFilterEnabled ? _dateFilter : DateTime.now();

    for (Plant p in allPlants) {
      for (Care c in p.cares) {
        var cpsr = (dateCheck.compareTo(c.effected!) / 60 / 60 / 24).round();

        if (cpsr >= c.cycles) {
          c.effected = DateTime.now();

          objectbox.plantBox.put(p);
        }
      }
    }

    setState(() {
      _dateFilterEnabled = false;
      _loadPlants();
    });
  }

  _deletePlant(Plant plant) async {
    await objectbox.removePlant(plant);
    _loadPlants();
  }

  List<Icon> _buildCares(BuildContext context, Plant plant) {
    final ThemeData theme = Theme.of(context);

    List<Icon> list = [];

    _cares[plant.name]!.forEach((key) {
      list.add(Icon(
        DefaultValues.getCare(key)!.icon,
        size: 21,
        color: DefaultValues.getCare(key)!.color,
      ));
    });


    return list;
  }

// TODO: Make a collection of cards (102)
// Replace this entire method
  List<GestureDetector> _buildPlantCards(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return _plants.map((plant) {
      return GestureDetector(
        onLongPress: () {
          _deletePlant(plant);
        },
        onLongPressCancel: () async {
          print(plant.name);
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarePlantScreen(title: plant.name),
              // Pass the arguments as part of the RouteSettings. The
              // DetailScreen reads the arguments from these settings.
              settings: RouteSettings(
                arguments: plant,
              ),
            ),
          );
          setState(() {
            _selectedIndex = 0;
            _loadPlants();
          });
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          // TODO: Adjust card heights (103)
          child: Column(
            // TODO: Center items on the card (103)
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          AspectRatio(
          aspectRatio: 18 / 12,
            child: plant.picture!.contains("assets/")
                ? Image.asset(
              plant.picture!,
              // TODO: Adjust the box size (102)
              fit: BoxFit.fitHeight,
            )
                : Image.file(
              File(plant.picture!),
              // TODO: Adjust the box size (102)
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                // TODO: Align labels to the bottom and center (103)
                crossAxisAlignment: CrossAxisAlignment.start,
                // TODO: Change innermost Column (103)
                children: <Widget>[
                // TODO: Handle overflowing labels (103)
                Text(
                plant.name,
                style: theme.textTheme.headline6,
                maxLines: 1,
              ),
              const SizedBox(height: 2.0),
              Text(
                plant.description,
                style: theme.textTheme.subtitle2,
              ),
              const SizedBox(height: 6.0),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  _buildCares(context, plant)

            )
            ],
          ),
        ),
      ),]
      ,
      )
      ,
      )
      );
    }).toList();
  }
}
