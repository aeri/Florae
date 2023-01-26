import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:florae/notifications.dart' as notify;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  int notificationTempo = 60;

  void _showIntegerDialog() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.selectHours),
            content: StatefulBuilder(builder: (context, builderState) {
              return NumberPicker(
                  selectedTextStyle: const TextStyle(color: Colors.teal),
                  value: (notificationTempo / 60).round(),
                  minValue: 1,
                  maxValue: 24,
                  onChanged: (value) {
                    setState(() {
                      notificationTempo = value * 60;
                    });
                    builderState(() => notificationTempo =
                        value * 60); //* to change on dialog state
                  });
            }),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.ok),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> getSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationTempo = prefs.getInt('notificationTempo') ?? 60;
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(AppLocalizations.of(context)!.tooltipSettings)),
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
                      title: Text(AppLocalizations.of(context)!.notifyEvery),
                      subtitle: notificationTempo != 0
                          ? Text((notificationTempo / 60).round().toString() +
                              " ${AppLocalizations.of(context)!.hours}")
                          : Text(AppLocalizations.of(context)!.never),
                      onTap: () {
                        _showIntegerDialog();
                      }),
                  ListTile(
                    leading: const Icon(Icons.info_outline_rounded),
                    subtitle: Transform.translate(
                      offset: const Offset(-10, -5),
                      child:
                          Text(AppLocalizations.of(context)!.notificationInfo),
                    ),
                  ),
                  ListTile(
                      trailing: const Icon(Icons.arrow_right),
                      leading: const Icon(Icons.circle_notifications,
                          color: Colors.red),
                      title: Text(
                          AppLocalizations.of(context)!.testNotificationButton),
                      onTap: () {
                        notify.singleNotification(
                            AppLocalizations.of(context)!.testNotificationTitle,
                            AppLocalizations.of(context)!.testNotificationBody,
                            2);
                      }),
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
                        title: Text(
                            AppLocalizations.of(context)!.aboutFloraeButton),
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
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('notificationTempo', notificationTempo);
          Navigator.pop(context);
        },
        label: Text(AppLocalizations.of(context)!.saveButton),
        icon: const Icon(Icons.save),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
