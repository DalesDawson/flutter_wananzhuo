import 'package:flutter/material.dart';

import './pages/HomePage.dart';
import './pages/HotSearchPage.dart';
import './pages/MinePage.dart';
import './pages/ProjectPage.dart';
import './pages/SystemPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Widget> pageData;

  @override
  void initState() {
    super.initState();
    pageData = new List();
    pageData
      ..add(HomePage())
      ..add(SystemPage())
      ..add(HotSearchPage())
      ..add(ProjectPage())
      ..add(MinePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        //导航栏
//        title: Text("玩安卓"),
//      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pageData,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('首页')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.layers), title: Text('体系')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('热搜')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.folder), title: Text('项目')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('我的')),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
