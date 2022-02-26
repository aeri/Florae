import 'package:florae/data/plant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:florae/data/plant.dart';
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
  List<Plant> _plantsFiltered = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget noPlants() {
    return Center(
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
                : 'The garden is empty, what if you plant something?',
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
    );
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
        title: Text(_selectedIndex == 0 ? "Today" : "Garden"),
        titleTextStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            fontFamily: "NotoSans"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_today),
            iconSize: 25,
            color: Colors.black54,
            tooltip: 'Show Calendar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
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
      body: _plants.length == 0
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
    final plants = await _plantRepository.getAllPlants();
    setState(() => _plants = plants);
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
                  child: Image.asset(
                    'assets/card-sample-image.jpg',
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
