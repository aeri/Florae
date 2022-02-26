import 'dart:io';

import 'package:florae/data/plant.dart';
import 'package:florae/data/plant_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:get_it/get_it.dart';
import 'package:sembast/timestamp.dart';
import 'package:intl/intl.dart';

class ManagePlantScreen extends StatefulWidget {
  const ManagePlantScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ManagePlantScreen> createState() => _ManagePlantScreen();
}

class _ManagePlantScreen extends State<ManagePlantScreen> {
  int _currentIntValue = 1;
  DateTime _planted = DateTime.now();
  final PlantRepository _plantRepository = GetIt.I.get();

  List<Plant> _plants = [];

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  XFile? _image;

  Future getImageFromCam() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

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
  void initState() {
    super.initState();
    _loadPlants();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('New plant'),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            fontFamily: "NotoSans"),
      ),
      //passing in the ListView.builder
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 2,
              margin: EdgeInsets.all(10),
              child: Container(
                  width: 370,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0), //or 15.0
                        child: Container(
                          height: 200,
                          color: Color(0xffFF0E58),
                          child: _image == null
                              ? Image.asset(
                                  'assets/card-sample-image.jpg',
                                  // TODO: Adjust the box size (102)
                                  fit: BoxFit.fitWidth,
                                )
                              : Image.file(File(_image!.path)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FloatingActionButton(
                            heroTag: "pic_cam",
                            onPressed: getImageFromCam,
                            tooltip: "Get image from camera",
                            child: Icon(Icons.add_a_photo),
                          ),
                          FloatingActionButton(
                            heroTag: "pick_gal",
                            onPressed: getImageFromGallery,
                            tooltip: "Get image from gallert",
                            child: Icon(Icons.wallpaper),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
            ),
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 2,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (findPlant(value) != null) {
                          return 'Plant name already exists';
                        }
                        return null;
                      },
                      cursorColor: Colors.teal,
                      maxLength: 20,
                      decoration: InputDecoration(
                        icon: Icon(Icons.local_florist),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          decorationColor: Colors.teal,
                        ),
                        fillColor: Colors.teal,
                        focusColor: Colors.teal,
                        hoverColor: Colors.teal,
                        helperText: 'Ex: Pilea',
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      //Normal textInputField will be displayed
                      maxLines: 3,
                      // when user presses enter it will adapt to it
                      controller: descriptionController,
                      cursorColor: Colors.teal,
                      maxLength: 100,
                      decoration: InputDecoration(
                        icon: Icon(Icons.topic),
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          decorationColor: Colors.teal,
                        ),
                        fillColor: Colors.teal,
                        focusColor: Colors.teal,
                        hoverColor: Colors.teal,
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                      ),
                    ),
                    TextFormField(
                      controller: locationController,
                      cursorColor: Colors.teal,
                      maxLength: 20,
                      decoration: InputDecoration(
                        icon: Icon(Icons.location_on),
                        labelText: 'Location',
                        labelStyle: TextStyle(
                          decorationColor: Colors.teal,
                        ),
                        fillColor: Colors.teal,
                        focusColor: Colors.teal,
                        hoverColor: Colors.teal,
                        helperText: 'Ex: Courtyard',
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: 370,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: <Widget>[
                    ListTile(
                      trailing: const Icon(Icons.arrow_right),
                      leading: const Icon(Icons.opacity),
                      title: const Text('Water every'),
                      subtitle: Text(_currentIntValue.toString() + " days"),
                      onTap: _showIntegerDialog,
                    ),
                    ListTile(
                      trailing: const Icon(Icons.arrow_right),
                      leading: Icon(Icons.today),
                      title: Text('Day planted'),
                      subtitle: Text(DateFormat.yMMMMEEEEd().format(_planted)),
                      onTap: () async {
                        DateTime? result = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(days: 1000)),
                            lastDate: DateTime.now());
                        setState(() {
                          _planted = result ?? DateTime.now();
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.group),
                      title: Text('Contact group'),
                      subtitle: Text('Not specified'),
                    ),
                  ]),
                ),
              ),
            ),
            SizedBox(height: 70),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final newPlant = Plant(
                name: nameController.text,
                cycles: _currentIntValue,
                createdAt: Timestamp.now(),
                description: descriptionController.text,
                location: locationController.text);
            final plant = await _plantRepository.insertPlant(newPlant);
            print(plant);
            Navigator.pop(context);
          }
        },
        label: const Text('Save'),
        icon: const Icon(Icons.save),
        backgroundColor: Colors.teal,
      ),
    );
  }

  _loadPlants() async {
    final plants = await _plantRepository.getAllPlants();
    setState(() => _plants = plants);
  }

  Plant? findPlant(String name) => _plants
      .cast()
      .firstWhere((plant) => plant.name == name, orElse: () => null);
}
