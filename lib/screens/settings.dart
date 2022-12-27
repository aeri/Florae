import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:florae/notifications.dart' as notify;

import 'package:intl/intl.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  int periodityCheckInHours = 1;

  void _showIntegerDialog(String care) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Select hours"),
            content: StatefulBuilder(builder: (context, SBsetState) {
              return NumberPicker(
                  selectedTextStyle: const TextStyle(color: Colors.teal),
                  value: periodityCheckInHours,
                  minValue: 1,
                  maxValue: 24,
                  onChanged: (value) {
                    setState(() {
                      periodityCheckInHours = value;
                    });
                    SBsetState(() => periodityCheckInHours =
                        value); //* to change on dialog state
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
        title: const Text('Settings'),
        elevation: 0.0,
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(children: <Widget>[
                  ListTile(
                      trailing: const Icon(Icons.arrow_right),
                      leading: const Icon(Icons.alarm, color: Colors.blue),
                      title: const Text('Notify every'),
                      subtitle: periodityCheckInHours != 0
                          ? Text(periodityCheckInHours.toString() + " hours")
                          : const Text("Never"),
                      onTap: () {
                        _showIntegerDialog("water");
                      }),
                  ListTile(
                      trailing: const Icon(Icons.arrow_right),
                      leading: const Icon(Icons.circle_notifications,
                          color: Colors.red),
                      title: const Text('Test notification'),
                      onTap: () {
                        notify.singleNotification("Florae Test Notification",
                            "This is a test message", 2);
                      }),

                  /*
                  const ListTile(
                    leading: Icon(Icons.group),
                    title: Text('Contact group'),
                    subtitle: Text('Not specified'),
                  ),
                   */
                ]),
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
                        trailing: const Icon(Icons.arrow_right),
                        leading: const Icon(Icons.text_snippet,
                            color: Colors.lightGreen),
                        title: const Text('About Florae'),
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'Florae',
                            applicationVersion: '1.0.0',
                            applicationLegalese: '© Naval Alcalá',
                          );
                        }),
                  ])),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.pop(context);
        },
        label: const Text('Save'),
        icon: const Icon(Icons.save),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
