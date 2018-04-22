import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  @override State<StatefulWidget> createState() => new LoaderState();
}

class LoaderState extends State<Loader> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _animation;

  @override void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: new Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = new CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _animation.addListener(() {
      setState(() {});
    });
    _animation.addStatusListener((AnimationStatus status) {});
    _controller.repeat();
  }

  @override void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override Widget build(BuildContext context) => new Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Container(
        color: Colors.white,
        height: _animation.value * 3,
        width: _animation.value * 33,
      ),
      new Padding(padding: const EdgeInsets.all(4.0)),
      new Container(
        color: Colors.white,
        height: _animation.value * 3,
        width: _animation.value * 66,
      ),
      new Padding(padding: const EdgeInsets.all(4.0)),
      new Container(
        color: Colors.white,
        height: _animation.value * 3,
        width: _animation.value * 100,
      ),
      new Padding(padding: const EdgeInsets.all(4.0)),
      new Container(
        color: Colors.white,
        height: _animation.value * 3,
        width: _animation.value * 66,
      ),
      new Padding(padding: const EdgeInsets.all(4.0)),
      new Container(
        color: Colors.white,
        height: _animation.value * 3,
        width: _animation.value * 33,
      ),
    ],
  );
}