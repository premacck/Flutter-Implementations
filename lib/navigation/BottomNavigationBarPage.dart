import 'package:flutter/material.dart';
import 'package:implementations/navigation/NavigationIconView.dart';

class BottomNavigationBarPage extends StatefulWidget {
  @override State<StatefulWidget> createState() => new BottomNavigationBarPageState();
}

class BottomNavigationBarPageState extends State<BottomNavigationBarPage> with TickerProviderStateMixin {

  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<NavigationIconView> _navigationBarItems;

  @override void initState() {
    super.initState();
    _navigationBarItems = [
      new NavigationIconView(icon: new Icon(Icons.accessibility_new), title: 'Prem', color: Colors.brown, vSync: this),
      new NavigationIconView(icon: new Icon(Icons.favorite), title: 'Loves', color: Colors.redAccent, vSync: this),
      new NavigationIconView(icon: new Icon(Icons.local_pizza), title: 'Pizza', color: Colors.teal, vSync: this),
      new NavigationIconView(icon: new Icon(Icons.show_chart), title: 'Very', color: Colors.deepOrangeAccent, vSync: this),
      new NavigationIconView(icon: new Icon(Icons.high_quality), title: 'Much', color: Colors.green, vSync: this),
    ];
    for (NavigationIconView view in _navigationBarItems) {
      view.controller.addListener(_rebuild);
    }
    _navigationBarItems[_currentIndex].controller.value = 1.0;
  }

  @override void dispose() {
    for (NavigationIconView view in _navigationBarItems) {
      view.controller.dispose();
    }
    super.dispose();
  }

  /// Rebuild in order to animate views.
  void _rebuild() => setState(() {});

  Widget _buildTransitionStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationBarItems) {
      transitions.add(view.transition(_type, context));
    }

    /// We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions,);
  }

  @override Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Bottom Navigation Bar'),
        actions: <Widget>[
          new PopupMenuButton<BottomNavigationBarType>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<BottomNavigationBarType>>[
              const PopupMenuItem<BottomNavigationBarType>(child: const Text('Fixed'), value: BottomNavigationBarType.fixed,),
              const PopupMenuItem<BottomNavigationBarType>(child: const Text('Shifting'), value: BottomNavigationBarType.shifting,),
            ],
          ),
        ],
      ),
      body: new Center(child: _buildTransitionStack(),),
      bottomNavigationBar: new BottomNavigationBar(
        type: _type,
        currentIndex: _currentIndex,
        items: _navigationBarItems.map((bottomNavigationBarItem) => bottomNavigationBarItem.item).toList(),
        onTap: (int index) {
          _navigationBarItems[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationBarItems[_currentIndex].controller.forward();
        },
      )
    );
  }
}