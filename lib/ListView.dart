import 'package:flutter/material.dart';

class MyListView extends StatefulWidget {
  @override State<StatefulWidget> createState() => new MyListViewState();
}

class MyListViewState extends State<MyListView> {

  List<bool> _data = new List<bool>();

  @override void initState() {
    setState(() {
      for(int i = 0; i < 20; i++) {
        _data.add(false);
      }
    });
    super.initState();
  }

  @override Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('ListView'),),
      body: new ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Container(
              padding: new EdgeInsets.all(16.0),
              child: new Column(
                children: <Widget>[
                  new Text('This is item $index'),
                  new CheckboxListTile(
                    value: _data[index],
                    controlAffinity: ListTileControlAffinity.leading,
                    title: new Text('Click me item $index'),
                    onChanged: (value) => _onChange(value, index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onChange(bool value, int index) => setState(() => _data[index] = value);
}