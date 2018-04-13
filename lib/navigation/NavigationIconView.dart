import 'package:flutter/material.dart';
import 'package:implementations/navigation/InnerPage.dart';

class NavigationIconView {

  final Icon icon;
  final Color color;
  final String title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  NavigationIconView({this.icon, this.title, this.color = Colors.deepOrangeAccent, TickerProvider vSync,}) :
        item = new BottomNavigationBarItem(icon: icon, title: new Text(title), backgroundColor: color,),
        controller = new AnimationController(duration: kThemeAnimationDuration, vsync: vSync,) {
    _animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  FadeTransition transition(BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate(_animation),
        child: new IconTheme(
          data: new IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: new Semantics(
            label: 'Placeholder for $title tab',
///            Here goes the pages you want to inflate. In this case the pages depend only on the icon and title provided
            child: new InnerPage.withColor(title, icon.icon, color),
          ),
        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}