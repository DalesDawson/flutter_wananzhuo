import 'package:flutter/material.dart';

class SystemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: new Text('体系'),
        ),
      ),
    );
  }
}
