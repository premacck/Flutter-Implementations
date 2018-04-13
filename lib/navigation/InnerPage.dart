import 'package:flutter/material.dart';
import 'package:implementations/main.dart';

class InnerPage extends StatelessWidget {

  final Icon _icon;
  final String _title;
  final Color _color;

  InnerPage(this._title, this._icon) : _color = _icon.color;

  InnerPage.withColor(this._title, IconData iconData, Color color) :_color = color, _icon = App.getIcon(iconData, color);

  @override Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            App.getWidget(_icon),
            App.getWidget(new Text(
              _title,
              style: new TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: _color,
                decorationColor: _color,
              ),
            )),
          ],
        ),
      ),
    );
  }
}