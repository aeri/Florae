
import 'dart:math';

import 'package:florae/plant_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:florae/plant.dart';
import 'package:sembast/timestamp.dart';

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
  PlantRepository _plantRepository = GetIt.I.get();
  List<Plant> _plants = [];
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPlants();
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 50,
            fontWeight: FontWeight.w900
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_today),
            iconSize: 25,
            color: Colors.black54,
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 25,
            color: Colors.black54,
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: _plants.length,
        itemBuilder: (context, index) {
          final plant = _plants[index];
          return ListTile(
            title: Text(plant.name),
            subtitle: Text("Intensity: ${plant.intensity}"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deletePlant(plant),
            ),
            leading: IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () => _editPlant(plant),
            ),
          );
        },
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
          selectedItemColor: Colors.teal
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _addPlant,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _addPlant() async {
    final list = ["pilea", "ficus", "coffe"]..shuffle();
    final name = list.first;
    final intensity = Random().nextInt(10);
    final newPlant = Plant(name: name, intensity: intensity, createdAt: Timestamp.now());
    final plant = await _plantRepository.insertPlant(newPlant);
    print(plant);
    _loadPlants();
  }
  _loadPlants() async {
    final plants = await _plantRepository.getAllPlants();
    setState(() => _plants = plants);
  }
  _deletePlant(Plant plant) async {
    print(await _plantRepository.deletePlant(plant.name));
    _loadPlants();
  }
  _editPlant(Plant plant) async {
    Plant updatedPlant = Plant.fromJson(plant.toJson());
    updatedPlant.intensity = plant.intensity + 1;
    await _plantRepository.updatePlant(updatedPlant);
    _loadPlants();
  }
}