import 'dart:async';
import 'package:flutter/material.dart';
import 'package:implementations/animations/Animations.dart';
import 'package:implementations/ApiCalls.dart';
import 'package:implementations/ListView.dart';
import 'package:implementations/navigation/BottomNavigationBarPage.dart';
import 'package:implementations/navigation/TabBarPage.dart';

void main() => runApp(new App());

const String LIST_VIEW = '/ListView';
const String TAB_BAR = '/TabBar';
const String BOTTOM_NAVIGATION_BAR = '/BottomNavigationBar';
const String API_CALLS = '/ApiCalls';
const String ANIMATIONS = '/Animations';

class App extends StatelessWidget {

  @override Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Implementations',
      color: Colors.deepOrange,
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.teal,
        brightness: Brightness.light,
      ),
      routes: <String, WidgetBuilder> {
        LIST_VIEW: (context) => new MyListView(),
        TAB_BAR: (context) => new TabBarPage(),
        BOTTOM_NAVIGATION_BAR: (context) => new BottomNavigationBarPage(),
        API_CALLS: (context) => new ApiCalls(),
        ANIMATIONS: (context) => new Animations(),
      },
      home: new MyApp(),
    );
  }

  static Widget getWidget(Widget child, [EdgeInsets pad = const EdgeInsets.all(16.0)]) => new Container(padding: pad, child: child,);

  static Icon getIcon(IconData iconData, Color color) => new Icon(iconData, size: 150.0, color: color,);

  static Container _get(Widget child, [EdgeInsets pad = const EdgeInsets.all(16.0)]) => new Container(padding: pad, child: child,);
}

class MyApp extends StatefulWidget {
  @override State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {

  int c;
  String _text = '';
  String _message = 'Enter text in TextField for custom implementations';
  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  bool _isChecked = false;
  int _selectedRadio = 0;
  int _selectedRadioListTile = 0;
  bool _switchValue = false;
  double _sliderValue = 0.0;
  String _dropDownValue;
  List<String> _dropDownValues = new List<String>();

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  String _answer = 'Tell us how you like Flutter';

  @override Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldState,
      appBar: new AppBar(title: new Text('Implementations'),),
      body: new SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: new Container(
          alignment: Alignment.center,
          padding: new EdgeInsets.all(16.0),
          child: new Center(
            child: new Center(
              child: new Column(
                children: <Widget>[
                  App._get(new TextField(onChanged: (value) => _onChanged(value), decoration: _getHint()), new EdgeInsets.all(0.0)),
                  _addSnackBar(),
                  _addAlertDialog(),
                  _addCustomizedTextField(),
                  _addCheckbox(),
                  _addCheckboxListTile(),
                  _addRadios(),
                  _addRadiosListTile(),
                  _addSwitch(),
                  _addSwitchListTile(),
                  _addSlider(),
                  _addDropDownButton(),
                  _addListView(),
                  _addDateAndTimePicker(),
                  _addCustomDialog(),
                  _addTabBar(),
                  _addBottomNavigationBar(),
                  _addHttpRequestAndRestApis(),
                  _addAnimation(),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  InputDecoration _getHint() => new InputDecoration(hintText: _message);

  _onChanged(String value) => setState(() => _text = value);

  //region SnackBar
  Widget _addSnackBar() => App._get(new RaisedButton(child: new Text('Show Snackbar!'), onPressed: () => _showSnackBar(_text)));

  _showSnackBar(String message) {
    if (message.isEmpty) message = _message;
    _scaffoldState.currentState.showSnackBar(new SnackBar(content: new Text(message)));
  }
  //endregion

  //region Alert Dialog
  Widget _addAlertDialog() => App._get(new RaisedButton(child: new Text('Show AlertDialog!'), onPressed: () => _showAlert(_text)));

  _showAlert(String message) {
    if (message.isEmpty) message = _message;
    showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text('Alert!'),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(onPressed: () => _dialogPressed(DialogActions.Maybe), child: new Text('Maybe')),
            new FlatButton(onPressed: () => _dialogPressed(DialogActions.No), child: new Text('No')),
            new FlatButton(onPressed: () => _dialogPressed(DialogActions.Yes), child: new Text('Yes')),
          ],
        )
    );
  }

  _dialogPressed(DialogActions value) {
    print('You pressed $value');
    Navigator.pop(context);
  }
  //endregion

  //region Text Field
  _addCustomizedTextField() {
    return App._get(new TextField(
      controller: _controller,
      autocorrect: true,
      decoration: new InputDecoration(
        contentPadding: new EdgeInsets.all(10.0),
        icon: new Icon(Icons.location_on),
        prefixIcon: new Icon(Icons.title),
        suffixIcon: new Icon(Icons.close),
        hintText: 'Play around with me...',
        labelText: 'Type some shit...',
      ),
    ), new EdgeInsets.all(0.0));
  }
  //endregion

  //region Checkbox and CheckboxListTile
  _addCheckbox() {
    return new Row(
      children: <Widget>[
        App._get(new Text('Click on the checkbox ->'), new EdgeInsets.only(left: 16.0)),
        App._get(new Checkbox(value: _isChecked, onChanged: (isChecked) => _checkChanged(isChecked))),
      ],
    );
  }

  _addCheckboxListTile() {
    return new CheckboxListTile(
      title: new Text('CheckboxListTile, click anywhere!'),
      subtitle: new Text('This is subtitle'),
      value: _isChecked,
      onChanged: (isChecked) => _checkChanged(isChecked),
      activeColor: Colors.redAccent,
      secondary: new Icon(Icons.album),
    );
  }

  _checkChanged(bool isChecked) {
    print(isChecked ? 'Checkbok checked' : 'Checkbox unchecked');
    setState(() => _isChecked = isChecked);
  }
  //endregion

  //region Radios
  Widget _addRadios() => App._get(new Column(children: _makeRadios(3),));

  List<Widget> _makeRadios(int numberOfRadios) {
    List<Widget> radios = new List<Widget> ();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(new Row(
        children: <Widget>[
          new Text('Radio button $i'),
          new Radio(value: i, groupValue: _selectedRadio, onChanged: (selection) => _onRadioSelected(selection)),
        ],
      ));
    }
    return radios;
  }

  _onRadioSelected(int selection) {
    print('Radio button $selection selected');
    setState(() => _selectedRadio = selection);
  }
  //endregion

  //region RadiosListTile
  Widget _addRadiosListTile() => App._get(new Column(children: _makeRadiosListTile(3),));

  List<Widget> _makeRadiosListTile(int numberOfRadios) {
    List<Widget> radios = new List<Widget> ();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(new RadioListTile(
        title: new Text('RadioListTile'),
        subtitle: new Text('Subtitle'),
        value: i,
        groupValue: _selectedRadioListTile,
        onChanged: (selection) => _onRadioListTileSelected(selection),
        activeColor: Colors.redAccent,
        secondary: new Icon(Icons.home),
      ));
    }
    return radios;
  }

  _onRadioListTileSelected(int selection) {
    print('Radio button $selection selected');
    setState(() => _selectedRadioListTile = selection);
  }
  //endregion

  //region Switch and SwitchListTile
  Widget _addSwitch() => App._get(_getSwitch());

  Widget _getSwitch() {
    return new Row(
      children: <Widget>[
        new Text('This is a simple switch'),
        new Switch(value: _switchValue, onChanged: (value) => _onSwitchToggled(value)),
      ],
    );
  }

  Widget _addSwitchListTile() => new SwitchListTile(
    title: new Text('SwitchListTile'),
    subtitle: new Text('Subtitle'),
    value: _switchValue,
    onChanged: (value) => _onSwitchToggled(value),
    activeColor: Colors.redAccent,
    secondary: new Icon(Icons.person),
  );

  void _onSwitchToggled(bool value) {
    print(value ? 'Switch on' : 'Switch off');
    setState(() => _switchValue = value);
  }
  //endregion

  //region Slider and ProgressBar
  Widget _addSlider() {
    return App._get(new Column(
      children: <Widget>[
        App._get(new Text('Progress value is ${(_sliderValue * .01).toStringAsFixed(3)}'), const EdgeInsets.only(top: 16.0)),
        App._get(new LinearProgressIndicator(value: _sliderValue * .01), const EdgeInsets.all(10.0)),
        new Text('Slider value is ${_sliderValue.toStringAsFixed(4)}'),
        new Slider(
          min: 0.0,
          max: 100.0,
          label: _sliderValue.toInt().toString(),
          value: _sliderValue,
          onChanged: (value) => _onSliderSeek(value),
        ),
      ],
    ), const EdgeInsets.only(top: 16.0));
  }

  void _onSliderSeek(double value) => setState(() => _sliderValue = value);
  //endregion

  //region DropDownButton
  void _initDropDownValues() {
    _dropDownValues.addAll(['Brian', 'Paul', 'Bob', 'Matt', 'Digg', 'Chris', 'Heather', 'Tammy']);
    _dropDownValue = _dropDownValues[0];
  }

  Widget _addDropDownButton() {
    return App._get(new DropdownButton(
      value: _dropDownValue,
      items: _dropDownValues.map((value) {
        return new DropdownMenuItem(
          value: value,
          child: new Row(
            children: <Widget>[
              new Icon(Icons.person),
              new Text('Person: $value'),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) => _onDropDownItemSelected(value),
    ));
  }

  void _onDropDownItemSelected(String value) => setState(() => _dropDownValue = value);
  //endregion

  //region ListView
  Widget _addListView() => App._get(new RaisedButton(
    child: new Text('ListView Example'),
    onPressed: () => Navigator.of(context).pushNamed(LIST_VIEW)
  ));
  //endregion

  //region Date and Time Picker
  Widget _addDateAndTimePicker() {
    return App._get(new Column(
      children: <Widget>[
        App._get(new Text('Date selected: ${_date.toString()}'), new EdgeInsets.only(top: 16.0, bottom: 10.0)),
        new RaisedButton(
          child: new Text('Select Date'),
          onPressed: () => _selectDate(context),
        ),
        App._get(new Text('Time selected: ${_time.toString()}'), new EdgeInsets.only(top: 16.0, bottom: 10.0)),
        new RaisedButton(
          child: new Text('Select Time'),
          onPressed: () => _selectTime(context),
        ),
      ],
    ));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2015),
      lastDate: new DateTime(2020)
    );

    if(pickedDate != null && pickedDate != _date) {
      print('Date selected: ${_date.toString()}');
      setState(() => _date = pickedDate);
    } else _showSnackBar('Please select a date');
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if(pickedTime != null && pickedTime != _time) {
      print('Time selected: ${_time.toString()}');
      setState(() => _time = pickedTime);
    } else _showSnackBar('Please select a date');
  }
  //endregion

  //region Custom Dialog
  Widget _addCustomDialog() {
    return App._get(new Column(
      children: <Widget>[
        new Text(_answer),
        new RaisedButton(child: new Text('SHOW CUSTOM DIALOG'), onPressed: _askUser),
      ],
    ));
  }

  Future<Null> _askUser() async {
    switch(await showDialog(
      context: context,
      child: new SimpleDialog(
        title: new Text('Liking Flutter yet?'),
        children: <Widget>[
          _getSimpleDialogOption('Yes!', DialogActions.Yes),
          _getSimpleDialogOption('No', DialogActions.No),
          _getSimpleDialogOption('Maybe', DialogActions.Maybe),
        ],
      ),
    )) {
      case DialogActions.Yes:
        _setAnswer('Yes');
        break;
      case DialogActions.No:
        _setAnswer('No');
        break;
      case DialogActions.Maybe:
        _setAnswer('Maybe');
        break;
      default:
        _setAnswer(null);
        break;
    }
  }

  Widget _getSimpleDialogOption(String text, DialogActions yes) => new SimpleDialogOption(
    child: App._get(new Text(text)),
    onPressed: () => Navigator.pop(context, DialogActions.Yes),
  );

  void _setAnswer(String value) => setState(() => _answer = value != null ? 'Your answer is $value' : 'Tell us how you like Flutter');
  //endregion

  //region Navigation (TabBar and BottomNavigationBar)
  Widget _addTabBar() => App._get(new RaisedButton(
      child: new Text('TabBar Example'),
      onPressed: () => Navigator.of(context).pushNamed(TAB_BAR),
    ));

  Widget _addBottomNavigationBar() => App._get(new RaisedButton(
      child: new Text('BottomNavigationBar Example'),
      onPressed: () => Navigator.of(context).pushNamed(BOTTOM_NAVIGATION_BAR),
    ));
  //endregion

  //region HTTP requests & REST APIs
  Widget _addHttpRequestAndRestApis() => App._get(new RaisedButton(
      child: new Text('HTTP requests & REST APIs'),
      onPressed: () => Navigator.of(context).pushNamed(API_CALLS),
    ));
  //endregion

  //region Animations
  Widget _addAnimation() => App.getWidget(new RaisedButton(
      child: new Text('Animations'),
      onPressed: () => Navigator.of(context).pushNamed(ANIMATIONS),));
  //endregion

  @override void initState() {
    _initDropDownValues();
    print('**** initState() ****');
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override void dispose() {
    print('**** dispose() ****');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state.toString());

    switch(state) {
      case AppLifecycleState.resumed:
        print('**** resumed ****');
        break;
      case AppLifecycleState.paused:
        print('**** paused ****');
        break;
      case AppLifecycleState.suspending:
        print('**** suspending ****');
        break;
      case AppLifecycleState.inactive:
        print('**** inactive ****');
        break;
    }
  }
}

enum DialogActions { Yes, No, Maybe }