import 'package:flutter/material.dart';
import 'package:implementations/main.dart';
import 'package:implementations/navigation/InnerPage.dart';

class TabBarPage extends StatefulWidget {
  @override State<StatefulWidget> createState() => new TabBarState();
}

class TabBarState extends State<TabBarPage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Tab Bar'),
        bottom: new TabBar(
          controller: _tabController,
          tabs: <Tab> [
            new Tab(icon: _getTab(Icons.accessibility_new, 'Prem'),),
            new Tab(icon: _getTab(Icons.favorite, 'Loves'),),
            new Tab(icon: _getTab(Icons.local_pizza, 'Pizza'),),
            new Tab(icon: _getTab(Icons.show_chart, 'Very'),),
            new Tab(icon: _getTab(Icons.high_quality, 'Much'),),
          ],
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new InnerPage('Prem', App.getIcon(Icons.accessibility_new, Colors.brown)),
          new InnerPage('Loves', App.getIcon(Icons.favorite, Colors.redAccent)),
          new InnerPage('Pizza', App.getIcon(Icons.local_pizza, Colors.teal)),
          new InnerPage('Very', App.getIcon(Icons.show_chart, Colors.deepOrangeAccent)),
          new InnerPage('Much', App.getIcon(Icons.high_quality, Colors.green)),
        ],
      ),
    );
  }

  Widget _getTab(IconData iconData, String text) => new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(iconData, size: 18.0,),
          new Text(text),
        ],
      ),
    );
}