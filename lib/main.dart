import 'package:flutter/material.dart';

import 'MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '玩安卓',
      debugShowCheckedModeBanner: false, //去掉页面右上角的debug标识
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
