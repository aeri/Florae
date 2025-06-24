import 'package:florae/data/settings/settings_manager.dart';
import 'package:florae/notifications.dart' as notify;
import 'package:flutter/material.dart';

import '../data/backup/backup_manager.dart';
import '../data/settings/settings.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  Settings settings = Settings();

  Future<void> getSettings() async {
    var currentSettings = await SettingsManager.getSettings();
    setState(() {
      settings = currentSettings;
    });
  }

  @override
  void initState() {
    super.initState();
    getSettings();
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
        titleTextStyle: Theme.of(context).textTheme.displayLarge,
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
                  ..._buildNotificationHours(),
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
                        leading: const Icon(Icons.backup, color: Colors.blueGrey),
                        title: Text(AppLocalizations.of(context)!.exportData),
                        onTap: () async {
                          var successfullyBackedUp =
                              await BackupManager.backup();
                          if (!successfullyBackedUp) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(AppLocalizations.of(context)!
                                    .unsuccessfullyBackup)));
                          }
                        }),
                    ListTile(
                        trailing: const Icon(Icons.arrow_right),
                        leading: const Icon(Icons.restore_outlined,
                            color: Colors.blueGrey),
                        title: Text(AppLocalizations.of(context)!.importData),
                        onTap: () async {
                          var successfullyRestored =
                              await BackupManager.restore();
                          if (!successfullyRestored) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(AppLocalizations.of(context)!
                                    .unsuccessfullyRestore)));
                          }
                        }),
                  ])),
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
                            applicationVersion: '3.1.0',
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
          await SettingsManager.writeSettings(settings);
          Navigator.pop(context);
        },
        label: Text(AppLocalizations.of(context)!.saveButton),
        icon: const Icon(Icons.save),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  List<Widget> _buildNotificationHours() {
    return [
      ListTile(
          trailing: const Icon(Icons.arrow_right),
          leading: const Icon(Icons.alarm, color: Colors.blue),
          title: Text(AppLocalizations.of(context)!.atDay),
          subtitle: settings.morningNotification != null
              ? Text(settings.morningNotification!.format(context))
              : Text(AppLocalizations.of(context)!.never),
          onTap: () {
            _showAlarmDialog(context, settings.morningNotification,
                (selectedTime) {
              setState(() {
                settings.morningNotification = selectedTime;
              });
            });
          }),
      ListTile(
          trailing: const Icon(Icons.arrow_right),
          leading: const Icon(Icons.alarm, color: Colors.blue),
          title: Text(AppLocalizations.of(context)!.atNoon),
          subtitle: settings.eveningNotification != null
              ? Text(settings.eveningNotification!.format(context))
              : Text(AppLocalizations.of(context)!.never),
          onTap: () {
            _showAlarmDialog(context, settings.eveningNotification,
                (selectedTime) {
              setState(() {
                settings.eveningNotification = selectedTime;
              });
            });
          }),
      ListTile(
          trailing: const Icon(Icons.arrow_right),
          leading: const Icon(Icons.alarm, color: Colors.blue),
          title: Text(AppLocalizations.of(context)!.atNight),
          subtitle: settings.nightNotification != null
              ? Text(settings.nightNotification!.format(context))
              : Text(AppLocalizations.of(context)!.never),
          onTap: () {
            _showAlarmDialog(context, settings.nightNotification,
                (selectedTime) {
              setState(() {
                settings.nightNotification = selectedTime;
              });
            });
          }),
    ];
  }

  void _showAlarmDialog(BuildContext context, TimeOfDay? notification,
      void Function(TimeOfDay?) onTimeChanged) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: notification ?? TimeOfDay.now(),
    );

    if (selectedTime == null) {
      notification = null;
    }
    onTimeChanged(selectedTime);
  }
}
