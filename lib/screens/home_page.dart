import 'dart:io';

import 'package:florae/data/plant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:florae/data/plant.dart';
import 'package:intl/intl.dart';
import 'package:sembast/timestamp.dart';
import 'manage_plant.dart';

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
  final PlantRepository _plantRepository = GetIt.I.get();
  List<Plant> _plants = [];
  bool _dateFilterEnabled = false;
  DateTime _dateFilter = DateTime.now();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPlants();
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
          title: const Text('Have you watered all the plants?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'This action will mark all plants as watered for today cycle.'),
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
                _waterAllPlants();
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
                  : "assets/undraw_gardening_re_e658.svg",
              semanticsLabel: 'Fall',
              alignment: Alignment.center,
              height: 250,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              _selectedIndex == 0
                  ? 'Yay! You don\'t have any pending plants to water!'
                  : 'The garden is empty, shall we plant something?',
              style: const TextStyle(
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Color(0x78000000),
                height: 1.4285714285714286,
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
                  icon: const Icon(Icons.assignment_turned_in),
                  iconSize: 25,
                  color: Colors.black54,
                  tooltip: 'Water all plants',
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
                        _dateFilter = result;
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
            onPressed: () async {},
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
              childAspectRatio: 8.0 / 9.0,
              children: _buildGridCards(context) // Changed code
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
    List<Plant> allPlants = await _plantRepository.getAllPlants();
    Timestamp dateCheck = _dateFilterEnabled
        ? Timestamp.fromDateTime(_dateFilter)
        : Timestamp.now();

    if (_selectedIndex == 0) {
      for (Plant p in allPlants) {
        var cpsr = (dateCheck.compareTo(p.watered!) / 60 / 60 / 24).round();
        if (cpsr != 0 && cpsr % p.cycles == 0) {
          plants.add(p);
        }
      }
    } else {
      plants = allPlants;
    }

    setState(() => _plants = plants);
  }

  _waterAllPlants() async {
    List<Plant> allPlants = await _plantRepository.getAllPlants();
    Timestamp dateCheck = _dateFilterEnabled
        ? Timestamp.fromDateTime(_dateFilter)
        : Timestamp.now();

    for (Plant p in allPlants) {
      var cpsr = (dateCheck.compareTo(p.watered!) / 60 / 60 / 24).round();

      if (cpsr >= p.cycles) {
        p.watered = Timestamp.fromDateTime(DateTime.now().subtract(const Duration(minutes: 5)));
        await _plantRepository.updatePlant(p);
      }
    }
    setState(() {
      _dateFilterEnabled = false;
      _loadPlants();
    });
  }

  _deletePlant(Plant plant) async {
    await _plantRepository.deletePlant(plant.name);
    _loadPlants();
  }

  /*
  _editPlant(Plant plant) async {
    Plant updatedPlant = Plant.fromJson(plant.toJson());
    updatedPlant.intensity = plant.intensity + 1;
    await _plantRepository.updatePlant(updatedPlant);
    _loadPlants();
  }
   */

// TODO: Make a collection of cards (102)
// Replace this entire method
  List<GestureDetector> _buildGridCards(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return _plants.map((plant) {
      return GestureDetector(
          onLongPress: () {
            _deletePlant(plant);
          },
          onLongPressCancel: () {
            print(plant.name);
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            // TODO: Adjust card heights (103)
            child: Column(
              // TODO: Center items on the card (103)
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18 / 11,
                  child: plant.picture!.contains("assets/")
                      ? Image.asset(
                          plant.picture!,
                          // TODO: Adjust the box size (102)
                          fit: BoxFit.fitWidth,
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
                        const SizedBox(height: 8.0),
                        Text(
                          plant.description,
                          style: theme.textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    }).toList();
  }
}
