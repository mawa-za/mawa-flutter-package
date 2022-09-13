import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_uploader/flutter_uploader.dart';

import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawa_package/dependencies.dart';

import 'package:equatable/equatable.dart';

void main() => runApp(CArdy());

/// *******************************************************************

class CArdy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(appBar: AppBar(
          title: const Text("Flutter GridView Demo"),
        ),
            body: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: List.generate(choices.length, (index) {
                  return Center(
                    child: SelectCard(choice: choices[index]),
                  );
                }
                )
            )
        )
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Home', icon: Icons.home),
  Choice(title: 'Contact', icon: Icons.contacts),
  Choice(title: 'Map', icon: Icons.map),
  Choice(title: 'Phone', icon: Icons.phone),
  Choice(title: 'Camera', icon: Icons.camera_alt),
  Choice(title: 'Setting', icon: Icons.settings),
  Choice(title: 'Album', icon: Icons.photo_album),
  Choice(title: 'WiFi', icon: Icons.wifi),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme;
    return Card(
        color: Colors.orange,
        child: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Icon(choice.icon, size:50.0, /*color: textStyle.color*/)),
              Text(choice.title, /*style: textStyle*/),
            ]
        ),
        )
    );
  }
}
/// *******************************************************************
