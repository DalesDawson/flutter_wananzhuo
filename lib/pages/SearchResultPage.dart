import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:flutter_wananzhuo/bean/HomeItem.dart' as homeItem;
import 'package:flutter_wananzhuo/utils/HttpUtil.dart';
import 'package:flutter_wananzhuo/utils/NavigatorUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchResultPage extends StatefulWidget {
  final String name;

  SearchResultPage(this.name);

  @override
  State<StatefulWidget> createState() {
    return new SearchResultState(this.name);
  }
}

class SearchResultState extends State<SearchResultPage> {
  final String name;
  int pageIndex = 0;
  List<homeItem.HomeItemDataData> resultList = [];

  SearchResultState(this.name);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        title: new Text(name),
      ),
      body: buildCustomScrollView(),
    );
  }

  @override
  void initState() {
    super.initState();
    getSearchList();
  }

  void getSearchList() async {
    FormData formData = new FormData.fromMap({
      "k": name,
    });
    var response = await new HttpUtil()
        .post(Api.SEARCH_WORD + pageIndex.toString() + "/json", data: formData);
    var item = new homeItem.HomeItem.fromJson(response);
    if (pageIndex == 0) {
      resultList = item.data.datas;
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
        resultList.addAll(item.data.datas);
      }
    }
    setState(() {});
  }

  // 顶部刷新
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex = 0;
        resultList.clear();
        this.getSearchList();
      });
    });
  }

// 底部刷新
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex += 1;
        this.getSearchList();
      });
    });
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
                  itemCount: resultList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildList(resultList[index]);
                  }));
        });
  }

  Widget buildList(homeItem.HomeItemDataData item) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          subtitle: new Column(
            children: <Widget>[
              new Text(item.title,
                  textAlign: TextAlign.left,
                  style: new TextStyle(color: Colors.black, fontSize: 15)),
              new Text(
                item.superChapterName + "/" + item.chapterName,
                style: new TextStyle(color: Colors.blue, fontSize: 13),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
