import 'package:flutter/material.dart';
import 'package:implementations/animations/Loader.dart';

class Animations extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Animations'),),
      backgroundColor: Colors.blueAccent,
      body: new Center(
        child: new Loader(),
      ),
    );
  }
}