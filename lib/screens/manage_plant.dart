import 'package:florae/data/plant.dart';
import 'package:florae/data/plant_repository.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:get_it/get_it.dart';
import 'package:sembast/timestamp.dart';

class ManagePlantScreen extends StatefulWidget {
  const ManagePlantScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ManagePlantScreen> createState() => _ManagePlantScreen();
}

class _ManagePlantScreen extends State<ManagePlantScreen> {
  int _currentIntValue = 1;
  final PlantRepository _plantRepository = GetIt.I.get();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  void _showIntegerDialog() async {
    await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Select cycles"),
            content: StatefulBuilder(builder: (context, SBsetState) {
              return NumberPicker(
                  selectedTextStyle: const TextStyle(color: Colors.teal),
                  value: _currentIntValue,
                  minValue: 1,
                  maxValue: 10,
                  onChanged: (value) {
                    setState(() => _currentIntValue =
                        value); // to change on widget level state
                    SBsetState(() =>
                        _currentIntValue = value); //* to change on dialog state
                  });
            }),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add new plant'),
          backgroundColor: Colors.teal,
          actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          iconSize: 25,
          color: Colors.white,
          tooltip: 'Show Snackbar',
          onPressed: () async {
            final newPlant = Plant(
                name: nameController.value.text,
                intensity: _currentIntValue,
                createdAt: Timestamp.now(),
                description: descriptionController.text,
                location: locationController.text);
            final plant = await _plantRepository.insertPlant(newPlant);
            print(plant);

            Navigator.pop(context);
          },
        )
      ]),
      //passing in the ListView.builder
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.local_florist),
              title: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.note),
              title: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  hintText: "Location",
                ),
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Cycles'),
              subtitle: Text(_currentIntValue.toString()),
              onTap: _showIntegerDialog,
            ),
            const ListTile(
              leading: Icon(Icons.today),
              title: Text('Birthday'),
              subtitle: Text('February 20, 1980'),
            ),
            const ListTile(
              leading: Icon(Icons.group),
              title: Text('Contact group'),
              subtitle: Text('Not specified'),
            )
          ],
        ),
      ),
    );
  }
}
