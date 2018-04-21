import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:implementations/main.dart';

class ApiCalls extends StatefulWidget {

  @override State<StatefulWidget> createState() {
    return new ApiCallsState();
  }
}

class ApiCallsState extends State<ApiCalls> {

  String _data = 'Data will appear here';

  Future<String> _getData(String url, [bool decode = false]) async {
    http.Response response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
//        "key": "thisIsWhereTheAuthenticationKeyGoes"
      }
    );
    print(response.body);
    setState(() => _data = !decode ? 'Calling ' + url + "\n\n\n\n" + response.body : JSON.decode(response.body).toString());
    return response.body;
  }

  @override Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('HTTP & API Calls'),
      ),
      body: new Container(
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                App.getWidget(new RaisedButton(
                  child: new Text('RAW'),
                  onPressed: () => _getData("https://jsonplaceholder.typicode.com/posts"),
                ), const EdgeInsets.only(top: 16.0, bottom: 16.0)),
                App.getWidget(new RaisedButton(
                  child: new Text('DECODED'),
                  onPressed: () => _getData("https://jsonplaceholder.typicode.com/posts", true),
                ), const EdgeInsets.only(top: 16.0, bottom: 16.0)),
                App.getWidget(new RaisedButton(
                  child: new Text('CLEAR'),
                  onPressed: () => setState(() => _data = 'Data will appear here'),
                ), const EdgeInsets.only(top: 16.0, bottom: 16.0)),
              ],
            ),
            new Expanded(child: new SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: new Text(_data, textAlign: TextAlign.start,),
            ),),
          ],
        ),
      ),
    );
  }

}