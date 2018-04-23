import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:implementations/main.dart';
import 'package:path_provider/path_provider.dart';

class FileStorage extends StatefulWidget {
  @override State<StatefulWidget> createState() => new FileStorageState();
}

class FileStorageState extends State<FileStorage> {

  TextEditingController _keyController = new TextEditingController();
  TextEditingController _valueController = new TextEditingController();

  File _jsonFile;
  Directory _dir;
  String _fileName = "myJsonFile.json";
  bool _fileExists = false;
  Map<String, String> fileContent;

  @override void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((directory) {
      _dir = directory;
      _jsonFile = new File(_dir.path + '/' + _fileName);
      _fileExists = _jsonFile.existsSync();
      if (_fileExists) setState(() => fileContent = json.decode(_jsonFile.readAsStringSync()));
    });
  }

  void _createFile(Map<String, String> content, Directory directory, String fileName) {
    print('Creating file...');
    File file = new File(directory.path + '/' + fileName);
    file.createSync();
    _fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, String value) {
    print('Writing to the file');
    Map<String, String> content = {key: value};
    if (_fileExists) {
      print('File Exists!');
      Map<String, String> jsonFileContent = json.decode(_jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      _jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print('File does not exist!');
      _createFile(content, _dir, _fileName);
    }
    setState(() => fileContent = json.decode(_jsonFile.readAsStringSync()));
  }

  @override Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('File Storage with JSON'),),
      body: App.getWidget(
        new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              App.getWidget(new Text('File Content', style: new TextStyle(fontWeight: FontWeight.bold),)),
              App.getWidget(new Text(fileContent.toString(), textAlign: TextAlign.center,), const EdgeInsets.all(0.0)),
              App.getWidget(new Text('Add to JSON file: ')),

              _getTextField(_keyController, 'Key'),
              _getTextField(_valueController, 'Value'),

              App.getWidget(new RaisedButton(
                child: new Text("Add 'Key - Value' Pair"),
                onPressed: () => writeToFile(_keyController.text, _valueController.text),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTextField(TextEditingController controller, String hint) =>
      App.getWidget(
        new TextField(controller: controller, textAlign: TextAlign.center, decoration: _getDecoration(hint),),
        const EdgeInsets.only(top: 10.0, bottom: 5.0)
      );

  InputDecoration _getDecoration(String hint) =>
      new InputDecoration(hintText: hint, hintStyle: new TextStyle(fontStyle: FontStyle.italic));

  @override void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    super.dispose();
  }
}