import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:florae/data/plant.dart';
import 'package:florae/notifications.dart' as notify;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../data/care.dart';
import '../data/default.dart';
import '../main.dart';
import 'manage_plant.dart';
import 'care_plant.dart';
import 'settings.dart';

enum Page { today, garden }

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
  Page _currentPage = Page.today;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadPlants();

    initializeDateFormatting();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    final prefs = await SharedPreferences.getInstance();
    final int? notificationTempo = prefs.getInt('notificationTempo');

    notify.initNotifications(AppLocalizations.of(context)!.careNotificationName,
        AppLocalizations.of(context)!.careNotificationDescription);

    try {
      var status = await BackgroundFetch.configure(
          BackgroundFetchConfig(
              minimumFetchInterval: notificationTempo ?? 60,
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
      List<Plant> allPlants = await garden.getAllPlants();

      List<String> plants = [];

      for (Plant p in allPlants) {
        for (Care c in p.cares) {
          var daysSinceLastCare = DateTime.now().difference(c.effected!).inDays;
          if (daysSinceLastCare != 0 && daysSinceLastCare % c.cycles == 0) {
            plants.add(p.name);
          }
          break;
        }
      }

      print("foreground florae detected plants " + plants.join(' '));

      if (plants.isNotEmpty) {
        notify.singleNotification(
            AppLocalizations.of(context)!.careNotificationTitle,
            plants.join(' '),
            7);
      }
    }
    BackgroundFetch.finish(taskId);
  }

  /// This event fires shortly before your task is about to timeout.  You must finish any outstanding work and call BackgroundFetch.finish(taskId).
  void _onBackgroundFetchTimeout(String taskId) {
    print("[BackgroundFetch] TIMEOUT: $taskId");
    BackgroundFetch.finish(taskId);
  }

  Future<void> _showWaterAllPlantsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.careAll),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.careAllBody),
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
                await _careAllPlants();
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              _currentPage == Page.today
                  ? (Theme.of(context).brightness == Brightness.dark)
                      ? "assets/undraw_different_love_a-3-rg.svg"
                      : "assets/undraw_fall_thyk.svg"
                  : (Theme.of(context).brightness == Brightness.dark)
                      ? "assets/undraw_flowers_vx06.svg"
                      : "assets/undraw_blooming_re_2kc4.svg",
              semanticsLabel: 'Fall',
              alignment: Alignment.center,
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              //apply padding to all four sides
              child: Text(
                _currentPage == Page.today
                    ? AppLocalizations.of(context)!.mainNoCares
                    : AppLocalizations.of(context)!.mainNoPlants,
                style: TextStyle(
                  fontFamily: 'NotoSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 0.065 * MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String titleSelector() {
    if (_dateFilterEnabled) {
      return DateFormat.EEEE(Localizations.localeOf(context).languageCode)
              .format(_dateFilter) +
          " " +
          DateFormat('d').format(_dateFilter);
    } else if (_currentPage == Page.garden) {
      return AppLocalizations.of(context)!.buttonGarden;
    } else {
      return AppLocalizations.of(context)!.buttonToday;
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

    String title = titleSelector();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: FittedBox(fit: BoxFit.fitWidth, child: Text(title)),
        titleTextStyle: Theme.of(context).textTheme.displayLarge,
        actions: <Widget>[
          _currentPage == Page.today
              ? IconButton(
                  icon: const Icon(Icons.checklist_rounded),
                  iconSize: 25,
                  color: Theme.of(context).colorScheme.primary,
                  tooltip: AppLocalizations.of(context)!.tooltipCareAll,
                  onPressed: () {
                    _showWaterAllPlantsDialog();
                  },
                )
              : const SizedBox.shrink(),
          _currentPage == Page.today
              ? IconButton(
                  icon: const Icon(Icons.calendar_today),
                  iconSize: 25,
                  color: Theme.of(context).colorScheme.primary,
                  tooltip: AppLocalizations.of(context)!.tooltipShowCalendar,
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
            color: Theme.of(context).colorScheme.primary,
            tooltip: AppLocalizations.of(context)!.tooltipSettings,
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
          : ResponsiveGridList(
              // Horizontal space between grid items
              horizontalGridSpacing: 10,
              // Vertical space between grid items
              verticalGridSpacing: 10,
              // Horizontal space around the grid
              horizontalGridMargin: 10,
              // Vertical space around the grid
              verticalGridMargin: 10,
              // The minimum item width (can be smaller, if the layout constraints are smaller)
              minItemWidth: 150,
              // The minimum items to show in a single row. Takes precedence over minItemWidth
              minItemsPerRow: 2,
              // The maximum items to show in a single row. Can be useful on large screens
              maxItemsPerRow: 6,
              children: _buildPlantCards(context) // Changed code
              ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _dateFilterEnabled = false;
            _currentPage = Page.values[index];
            _loadPlants();
          });
        },
        selectedIndex: _currentPage.index,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon:
                Icon(Icons.eco, color: Theme.of(context).colorScheme.surface),
            icon: const Icon(Icons.eco_outlined),
            label: AppLocalizations.of(context)!.buttonToday,
          ),
          NavigationDestination(
            selectedIcon:
                Icon(Icons.grass, color: Theme.of(context).colorScheme.surface),
            icon: const Icon(Icons.grass_outlined),
            label: AppLocalizations.of(context)!.buttonGarden,
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ManagePlantScreen(
                    title: "Manage plant", update: false),
              ));
          setState(() {
            _currentPage = Page.garden;
            _loadPlants();
          });
        },
        tooltip: AppLocalizations.of(context)!.tooltipNewPlant,
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _loadPlants() async {
    List<Plant> plants = [];
    Map<String, List<String>> cares = {};

    List<Plant> allPlants = await garden.getAllPlants();
    DateTime dateCheck = _dateFilterEnabled ? _dateFilter : DateTime.now();

    bool inserted = false;
    bool requiresInsert = false;

    if (_currentPage == Page.today) {
      for (Plant p in allPlants) {
        cares[p.name] = [];
        for (Care c in p.cares) {
          var daysSinceLastCare = dateCheck.difference(c.effected!).inDays;

          // If calendar day selected, add only the care that must be attended on a certain day.
          // Past care is assumed to have been correctly attended to in due time.
          if (_dateFilterEnabled) {
            requiresInsert =
                daysSinceLastCare != 0 && daysSinceLastCare % c.cycles == 0;
          }
          // Else, add all unattended care, current and past
          else {
            requiresInsert =
                daysSinceLastCare != 0 && daysSinceLastCare / c.cycles >= 1;
          }
          if (requiresInsert) {
            if (!inserted) {
              plants.add(p);
              inserted = true;
            }
            cares[p.name]!.add(c.name);
          }
        }
        inserted = false;
      }
    } else {
      plants = allPlants;
      // Alphabetically sort
      plants.sort((a, b) => a.name.compareTo(b.name));
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
    List<Plant> allPlants = await garden.getAllPlants();

    DateTime dateCheck = _dateFilterEnabled ? _dateFilter : DateTime.now();

    for (Plant p in allPlants) {
      for (Care c in p.cares) {
        var daysSinceLastCare = dateCheck.difference(c.effected!).inDays;
        if (daysSinceLastCare != 0 && daysSinceLastCare % c.cycles == 0) {
          c.effected = DateTime.now();
        }
      }
      await garden.updatePlant(p);
    }

    setState(() {
      _dateFilterEnabled = false;
      _loadPlants();
    });
  }

  _openPlant(Plant plant) async {
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
      _loadPlants();
    });
  }

  List<Icon> _buildCares(BuildContext context, Plant plant) {
    List<Icon> list = [];

    for (var care in _cares[plant.name]!) {
      list.add(
        Icon(DefaultValues.getCare(context, care)!.icon,
            color: DefaultValues.getCare(context, care)!.color),
      );
    }

    return list;
  }

  List<GestureDetector> _buildPlantCards(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return _plants.map((plant) {
      return GestureDetector(
          onLongPressCancel: () async {
            await _openPlant(plant);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18 / 12,
                  child: plant.picture!.contains("florae_avatar")
                      ? Image.asset(
                          plant.picture!,
                          fit: BoxFit.fitHeight,
                        )
                      : Image.file(
                          File(plant.picture!),
                          fit: BoxFit.fitWidth,
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            plant.name,
                            style: theme.textTheme.titleLarge,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          plant.description,
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 8.0),
                        SizedBox(
                            height: 20.0,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: plant.cares.isNotEmpty
                                  ? Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: _buildCares(context, plant))
                                  : null,
                            )),
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
