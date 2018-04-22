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

  static const int RAW = 0;
  static const int DECODED = 1;
  static const int IN_LIST_VIEW = 2;

  String _data = 'Data will appear here';
  List _dataList;

  Future _getData(String url, [int action = RAW]) async {
    http.Response response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
//        "key": "thisIsWhereTheAuthenticationKeyGoes"
      }
    );
    print(response.body);
    setState(() {
      if (action == IN_LIST_VIEW) _dataList = JSON.decode(response.body);
      if (action == RAW || action == DECODED) {
        _data = action == RAW ? 'Calling ' + url + "\n\n\n\n" + response.body : JSON.decode(response.body).toString();
      }
    });
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                App.getWidget(new RaisedButton(
                  child: new Text('RAW DATA'),
                  onPressed: () => _getData("https://jsonplaceholder.typicode.com/posts"),
                ), const EdgeInsets.only(top: 16.0, bottom: 16.0)),
                App.getWidget(new RaisedButton(
                  child: new Text('DECODED DATA'),
                  onPressed: () => _getData("https://jsonplaceholder.typicode.com/posts", DECODED),
                ), const EdgeInsets.only(top: 16.0, bottom: 16.0)),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                App.getWidget(new RaisedButton(
                  child: new Text('GET IN LISTVIEW'),
                  onPressed: () => _getData("https://jsonplaceholder.typicode.com/posts", IN_LIST_VIEW),
                ), const EdgeInsets.only(top: 16.0, bottom: 16.0)),
                App.getWidget(new RaisedButton(
                  child: new Text('CLEAR'),
                  onPressed: () => setState(() {
                    _data = 'Data will appear here';
                    _dataList = null;
                  }),
                ), const EdgeInsets.only(top: 16.0, bottom: 16.0)),
              ],
            ),
            new Expanded(child: new SingleChildScrollView(
              child: new Text(_data, textAlign: TextAlign.start,),
            )),
            new Expanded(
              child: new ListView.builder(
                itemCount: _dataList != null ? _dataList.length : 0,
                itemBuilder: (BuildContext context, int index) => new Card(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        App.getWidget(new Text(_dataList[index]['title'])),
                        App.getWidget(new Text(_dataList[index]['body'])),
                      ],
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}