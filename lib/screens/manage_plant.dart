import 'package:flutter/material.dart';


class ManagePlantScreen extends StatelessWidget {
  ManagePlantScreen({Key? key, required this.title}) : super(key: key);

  final String title;


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Todos'),
    ),
    //passing in the ListView.builder
    body: new Column(
      children: <Widget>[
        new ListTile(
          leading: const Icon(Icons.person),
          title: new TextField(
            decoration: new InputDecoration(
              hintText: "Name",
            ),
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.phone),
          title: new TextField(
            decoration: new InputDecoration(
              hintText: "Phone",
            ),
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.email),
          title: new TextField(
            decoration: new InputDecoration(
              hintText: "Email",
            ),
          ),
        ),
        const Divider(
          height: 1.0,
        ),
        new ListTile(
          leading: const Icon(Icons.label),
          title: const Text('Nick'),
          subtitle: const Text('None'),
        ),
        new ListTile(
          leading: const Icon(Icons.today),
          title: const Text('Birthday'),
          subtitle: const Text('February 20, 1980'),
        ),
        new ListTile(
          leading: const Icon(Icons.group),
          title: const Text('Contact group'),
          subtitle: const Text('Not specified'),
        )
      ],
    ),
    );
  }
}