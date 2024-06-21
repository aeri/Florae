import 'dart:io';
import 'package:florae/data/plant.dart';
import 'package:florae/screens/picture_viewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/care.dart';
import '../data/default.dart';
import '../main.dart';
import 'manage_plant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CarePlantScreen extends StatefulWidget {
  const CarePlantScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CarePlantScreen> createState() => _CarePlantScreen();
}

class _CarePlantScreen extends State<CarePlantScreen> {
  int periodicityInHours = 1;
  Map<Care, bool?> careCheck = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String buildCareMessage(int daysToCare) {
    if (daysToCare == 0) {
      return AppLocalizations.of(context)!.now;
    } else if (daysToCare < 0) {
      return "${AppLocalizations.of(context)!.daysLate} ${daysToCare.abs()} ${AppLocalizations.of(context)!.days}";
    } else {
      return "$daysToCare ${AppLocalizations.of(context)!.daysLeft}";
    }
  }

  Future<void> _showDeletePlantDialog(Plant plant) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.deletePlantTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.deletePlantBody),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.yes),
              onPressed: () async {
                await garden.deletePlant(plant);

                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        );
      },
    );
  }

  List<CheckboxListTile> _buildCares(BuildContext context, Plant plant) {
    return plant.cares.map((care) {
      int daysToCare =
          care.cycles - DateTime.now().difference(care.effected!).inDays;

      if (careCheck[care] == null) {
        careCheck[care] = daysToCare <= 0;
      }
      return CheckboxListTile(
        title: Text(DefaultValues.getCare(context, care.name)!.translatedName),
        subtitle: Text(buildCareMessage(daysToCare)),
        value: careCheck[care],
        onChanged: (bool? value) {
          setState(() {
            careCheck[care] = value;
          });
        },
        secondary: Icon(DefaultValues.getCare(context, care.name)!.icon,
            color: DefaultValues.getCare(context, care.name)!.color),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final plant = ModalRoute.of(context)!.settings.arguments as Plant;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          title: FittedBox(fit: BoxFit.fitWidth, child: Text(plant.name)),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              iconSize: 25,
              color: Theme.of(context).colorScheme.primary,
              tooltip: AppLocalizations.of(context)!.tooltipEdit,
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
          titleTextStyle: Theme.of(context).textTheme.displayLarge,
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
                  child: InkWell(
                    onTap: () {
                      if (!plant.picture!.contains("assets/")) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PictureViewer(
                                    picture: plant.picture,
                                  )),
                        );
                      }
                    },
                    child: SizedBox(
                        child: Column(
                      children: <Widget>[
                        ClipRRect(
                          child: SizedBox(
                            height: 220,
                            child: plant.picture!.contains("assets/")
                                ? Image.asset(
                                    plant.picture!,
                                    fit: BoxFit.fitHeight,
                                  )
                                : Image.file(
                                    File(plant.picture!),
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
                        ),
                      ],
                    )),
                  ),
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
                        leading: const Icon(Icons.topic),
                        title: Text(
                            AppLocalizations.of(context)!.labelDescription),
                        subtitle: Text(plant.description)),
                    ListTile(
                        leading: const Icon(Icons.location_on),
                        title:
                            Text(AppLocalizations.of(context)!.labelLocation),
                        subtitle: Text(plant.location ?? "")),
                    ListTile(
                        leading: const Icon(Icons.cake),
                        title:
                            Text(AppLocalizations.of(context)!.labelDayPlanted),
                        subtitle: Text(DateFormat.yMMMMd(
                                Localizations.localeOf(context).languageCode)
                            .format(plant.createdAt))),
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
                  await _showDeletePlantDialog(plant);
                },
                label: Text(AppLocalizations.of(context)!.deleteButton),
                icon: const Icon(Icons.delete),
                backgroundColor: Colors.redAccent,
              ),
              FloatingActionButton.extended(
                heroTag: "care",
                onPressed: () async {
                  if (!careCheck.containsValue(true)) {
                    print("NO CARES");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text(AppLocalizations.of(context)!.noCaresError)));
                  } else {
                    careCheck.forEach((key, value) {
                      if (value == true) {
                        var careIndex = plant.cares
                            .indexWhere((element) => element.name == key.name);
                        if (careIndex != -1) {
                          plant.cares[careIndex].effected = DateTime.now();
                        }
                      }
                    });

                    await garden.updatePlant(plant);
                    Navigator.of(context).pop();
                  }
                },
                label: Text(AppLocalizations.of(context)!.careButton),
                icon: const Icon(Icons.check),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              )
            ],
          ),
        ));
  }
}
