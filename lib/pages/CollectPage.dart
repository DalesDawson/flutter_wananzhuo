import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:flutter_wananzhuo/bean/HomeItem.dart' as homeItem;
import 'package:flutter_wananzhuo/utils/CollectUtil.dart';
import 'package:flutter_wananzhuo/utils/HttpUtil.dart';
import 'package:flutter_wananzhuo/utils/NavigatorUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'LoginPage.dart';

class CollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CollectPageState();
}

class CollectPageState extends State {
  int pageIndex = 0;
  List<homeItem.HomeItemDataData> list = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: new Text("玩安卓"),
      ),
      body: buildCustomScrollView(),
    );
  }

  @override
  void initState() {
    super.initState();
    getCollectList(pageIndex);
  }

  void getCollectList(int page) async {
    var response =
        await new HttpUtil().get(Api.COLLECT_LIST + page.toString() + "/json");
    var item = new homeItem.HomeItem.fromJson(response);
    if (item.errorCode == 0) {
      if (pageIndex == 0) {
        list = item.data.datas;
      } else {
        if (item.data.datas.length == 0) {
          Fluttertoast.showToast(
              msg: "我也是有底线的！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 2,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          list.addAll(item.data.datas);
        }
      }
      setState(() {});
    } else {
      Fluttertoast.showToast(
          msg: item.errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new LoginPage()));
    }
  }

  Widget buildCustomScrollView() {
    return new Refresh(
        onFooterRefresh: onFooterRefresh,
        onHeaderRefresh: onHeaderRefresh,
        childBuilder: (BuildContext context,
            {ScrollController controller, ScrollPhysics physics}) {
          return new Container(
              child: new ListView.builder(
                  physics: physics,
                  controller: controller,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildList(list[index]);
                  }));
        });
  }

  Widget buildList(homeItem.HomeItemDataData item) {
    if (list.length > 0) {
      return new Card(
        child: new InkWell(
          onTap: () {
            NavigatorUtil.toDetails(context, item.link, item.title);
          },
          child: new ListTile(
            title: new Row(
                children: <Widget>[
                  new Text(item.author,
                      textAlign: TextAlign.left,
                      style: new TextStyle(color: Colors.grey, fontSize: 13)),
                  new Text(item.niceDate,
                      textAlign: TextAlign.right,
                      style: new TextStyle(color: Colors.grey, fontSize: 13))
                ],
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center),
            subtitle: new Column(
              children: <Widget>[
                new Text(item.title,
                    textAlign: TextAlign.left,
                    style: new TextStyle(color: Colors.black, fontSize: 15)),
                new Row(
                  children: <Widget>[
                    new Text(item.chapterName,
                        style: new TextStyle(color: Colors.blue, fontSize: 13)),
                    new IconButton(
                        icon: Image.asset(
                          'images/icon_like_select.png',
                          height: 20,
                          width: 20,
                        ),
                        onPressed: () {
                          CollectUtil.uncollect(item.id,
                              item.originId != -1 ? item.originId : -1);
                        })
                  ],
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      );
    } else {
      return new Container(
          child: new Text(
        "暂无数据",
        style: new TextStyle(fontSize: 20.0, color: Colors.blue),
      ));
    }
  }

  // 顶部刷新
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex = 0;
        list.clear();
        this.getCollectList(pageIndex);
      });
    });
  }

// 底部刷新
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex += 1;
        this.getCollectList(pageIndex);
      });
    });
  }
}
