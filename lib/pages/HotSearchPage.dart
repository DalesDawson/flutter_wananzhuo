import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:flutter_wananzhuo/pages/DetailsPage.dart';
import 'package:flutter_wananzhuo/pages/SearchResultPage.dart';
import 'package:flutter_wananzhuo/utils/HttpUtil.dart';
import 'package:flutter_wananzhuo/bean/hot_search_friend_entity.dart'
    as hotFriend;
import 'package:flutter_wananzhuo/bean/hot_search_key_entity.dart' as hotKey;

class HotSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HotSearchPageState();
}

class _HotSearchPageState extends State<HotSearchPage> {
  final controller = TextEditingController();
  
  List<hotKey.HotSearchKeyData> hotKeyList;
  List<hotFriend.HotSearchFriendData> hotFriendList;
  List<Color> colors = [
    Colors.blue,
    Colors.deepOrange,
    Colors.amber,
    Colors.pink[200],
    Colors.green,
    Colors.purple,
    Colors.pink,
    Colors.teal
  ];
  final random = new Random();

//  int dataSet;

  int randomNum() {
    return random.nextInt(7);
  }

  @override
  void initState() {
    super.initState();
    getKeyList();
    getFriendList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: buildCustomScrollView(),
    );
  }

  //获取热搜关键词列表
  void getKeyList() async {
    var response = await new HttpUtil().get(Api.HOT_WORD);
    var item = new hotKey.HotSearchKey.fromJson(response);
    setState(() {
      hotKeyList = item.data;
    });
  }

  //获取常用网站
  void getFriendList() async {
    var response = await new HttpUtil().get(Api.HOT_FRIEND);
    var item = new hotFriend.HotSearchFriend.fromJson(response);
    setState(() {
      hotFriendList = item.data;
    });
  }

  Widget buildCustomScrollView() {
    return new Container(
        child: new ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return buildSearch();
              } else if (index == 1) {
                return buildTitle("大家都在搜");
//                return buildList(homeList[index - headerCount]);
              } else if (index == 2) {
                return buildKeyList();
              } else if (index == 3) {
                return buildTitle("常用网站");
              } else if (index == 4) {
                return buildFriendList();
              }
            }));
  }

  Widget buildSearch() {
    return new Container(
      padding: EdgeInsets.only(left: 5.0, top: 3.0, right: 5.0, bottom: 2.0),
      width: 200,
      height: 50,
      child: new Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: Colors.grey, // 光标颜色
              // 默认设置
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  border: new OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  hintText: "输入关键字搜索",
                  hintStyle: new TextStyle(
                      fontSize: 14, color: Color.fromARGB(50, 0, 0, 0))),
              style: new TextStyle(fontSize: 14, color: Colors.black),
            ),
            flex: 3,
          ),
          Expanded(
            child: FlatButton(
              padding:
                  EdgeInsets.only(left: 5.0, top: 3.0, right: 5.0, bottom: 2.0),
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("搜索"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: () => {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                new SearchResultPage(controller.text)))
                  },
            ),
            flex: 1,
          ),
        ],
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Widget buildTitle(String title) {
    return new Container(
      padding: EdgeInsets.only(left: 10.0, top: 5.0, right: 5.0, bottom: 2.0),
      child: new Text(title,
          textAlign: TextAlign.left,
          style: new TextStyle(color: Colors.black, fontSize: 16)),
    );
  }

  Widget buildKeyList() {
    return new Container(
        decoration: new BoxDecoration(color: Colors.grey[300]),
        margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 2.0, top: 2.0),
        child: new Wrap(
          children: hotKeyList.map((item) {
            return new GestureDetector(
                child: Container(
                    decoration: new BoxDecoration(
                        color: colors[randomNum()],
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
                    margin: EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 5.0, top: 5.0),
                    child: Text(item.name,
                        style: new TextStyle(
                            color: Colors.white, fontSize: 16.0))),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new SearchResultPage(item.name)));
                });
          }).toList(),
        ));
  }

  Widget buildFriendList() {
    return new Container(
        decoration: new BoxDecoration(color: Colors.grey[300]),
        margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 2.0, top: 2.0),
        child: new Wrap(
          children: hotFriendList.map((item) {
            return new GestureDetector(
                child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
                    margin: EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 5.0, top: 5.0),
                    child: Text(item.name,
                        style: new TextStyle(
                            color: colors[randomNum()], fontSize: 16.0))),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new DetailsPage(item.link, item.name)));
                });
          }).toList(),
        ));
  }
}
