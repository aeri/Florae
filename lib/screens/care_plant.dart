import 'dart:io';
import 'package:florae/data/plant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/default.dart';
import '../main.dart';
import 'manage_plant.dart';

class CarePlantScreen extends StatefulWidget {
  const CarePlantScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CarePlantScreen> createState() => _CarePlantScreen();
}

class _CarePlantScreen extends State<CarePlantScreen> {
  int periodityCheckInHours = 1;
  Map<String, bool?> cares = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int daysToCare(Care c) {
    return c.cycles - DateTime.now().difference(c.effected!).inDays;
  }

  List<CheckboxListTile> _buildCares(BuildContext context, Plant plant) {
    final ThemeData theme = Theme.of(context);

    return plant.cares.map((care) {
      int dtc = daysToCare(care);
      return CheckboxListTile(
        title: Text(DefaultValues.getCare(care.name)!.translatedName),
        subtitle: Text((dtc <= 0) ? "Now" : "$dtc days left to ${care.name}"),
        value: cares[care.name] ?? (dtc <= 0),
        onChanged: (bool? value) {
          setState(() {
            cares[care.name] = value;
          });
        },
        secondary: Icon(DefaultValues.getCare(care.name)!.icon,
            color: DefaultValues.getCare(care.name)!.color),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final plant = ModalRoute.of(context)!.settings.arguments as Plant;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(plant.name),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              iconSize: 25,
              color: Colors.black54,
              tooltip: 'Edit this care to all plants',
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => ManagePlantScreen(
                          title: "Manage plant", update: true, plant: plant),
                    ));
              },
            )
          ],
          titleTextStyle: const TextStyle(
              color: Colors.black54,
              fontSize: 40,
              fontWeight: FontWeight.w800,
              fontFamily: "NotoSans"),
        ),
        //passing in the ListView.builder
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 2,
                  child: SizedBox(
                      child: Column(
                    children: <Widget>[
                      ClipRRect(
                        child: Container(
                          height: 220,
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
                      ),
                    ],
                  )),
                ),
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.topic),
                        title: Text('Description'),
                        subtitle: Text(plant.description)),
                    ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('Location'),
                        subtitle: Text(plant.location ?? "")),
                    ListTile(
                        leading: Icon(Icons.cake),
                        title: Text('Day planted'),
                        subtitle:
                            Text(DateFormat.yMMMMd().format(plant.createdAt))),
                  ]),
                ),
                Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(children: _buildCares(context, plant))),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton.extended(
                heroTag: "delete",
                onPressed: () async {
                  await objectbox.removePlant(plant);
                  Navigator.of(context).pop();
                },
                label: const Text('Delete'),
                icon: const Icon(Icons.delete),
                backgroundColor: Colors.redAccent,
              ),
              FloatingActionButton.extended(
                heroTag: "care",
                onPressed: () {
                  if (!cares.containsValue(true)) {
                    print("NO CARES");
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Select at least one care')));
                  } else {
                    cares.forEach((key, value) {
                      int careIndex = plant.cares
                          .indexWhere((element) => element.name == key);
                      plant.cares[careIndex].effected = DateTime.now();
                    });
                    objectbox.plantBox.put(plant);

                    Navigator.of(context).pop();
                  }
                },
                label: const Text('Care'),
                icon: const Icon(Icons.check),
                backgroundColor: Colors.greenAccent,
              )
            ],
          ),
        ));
  }
}
