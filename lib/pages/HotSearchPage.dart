import 'package:flutter/material.dart';

class HotSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HotSearchPageState();
}

class _HotSearchPageState extends State<HotSearchPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: new Text('热搜'),
        ),
      ),
    );
  }
}
