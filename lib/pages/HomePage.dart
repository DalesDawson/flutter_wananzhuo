import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:flutter_wananzhuo/bean/BannerItem.dart' as bannerItem;
import 'package:flutter_wananzhuo/bean/HomeItem.dart' as homeItem;
import 'package:flutter_wananzhuo/utils/CollectUtil.dart';
import 'package:flutter_wananzhuo/utils/HttpUtil.dart';
import 'package:flutter_wananzhuo/utils/NavigatorUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bannerItem.BannerData> bannerList = [];
  List<homeItem.HomeItemDataData> homeList = [];
  final int headerCount = 1;
  int pageIndex = 0;
  var bannerIndex = 0;

//  final int pageSize = 20;

  @override
  void initState() {
    super.initState();
    getBannerList();
    getHomeList();
  }

// 顶部刷新
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex = 0;
        bannerList.clear();
        homeList.clear();
        this.getBannerList();
        this.getHomeList();
      });
    });
  }

// 底部刷新
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex += 1;
        this.getHomeList();
      });
    });
  }

//获取轮播图接口
  void getBannerList() async {
    var response = await new HttpUtil().get(Api.BANNER_LIST);
    var item = new bannerItem.BannerItem.fromJson(response);
    bannerList = item.data;
    setState(() {});
  }

  void getHomeList() async {
    var response = await new HttpUtil()
        .get(Api.HOME_LIST + pageIndex.toString() + "/json");
    var item = new homeItem.HomeItem.fromJson(response);
    if (pageIndex == 0) {
      homeList = item.data.datas;
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
        homeList.addAll(item.data.datas);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: new Text("玩安卓"),
        ),
        body: buildCustomScrollView());
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
                  itemCount: homeList.length + headerCount,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return buildBanner();
                    } else {
                      return buildList(homeList[index - headerCount]);
                    }
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
              crossAxisAlignment: CrossAxisAlignment.center),
          subtitle: new Column(
            children: <Widget>[
              new Text(item.title,
                  textAlign: TextAlign.left,
                  style: new TextStyle(color: Colors.black, fontSize: 15)),
              new Row(
                children: <Widget>[
                  new Text(item.superChapterName + "/" + item.chapterName,
                      style: new TextStyle(color: Colors.blue, fontSize: 13)),
                  new IconButton(
                      icon: Image.asset(
                        'images/icon_like_normal.png',
                        height: 20,
                        width: 20,
                      ),
                      onPressed: () {
                        CollectUtil.collect(item.id);
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
  }

//  void collect(int id) async {
//    var response =
//        await new HttpUtil().post(Api.COLLECT + id.toString() + "/json");
////    print(response.toString());
//    var item = new homeItem.HomeItem.fromJson(response);
//    if (item.errorCode == 0) {
//      Fluttertoast.showToast(
//          msg: "收藏成功！",
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 2,
//          backgroundColor: Colors.blue,
//          textColor: Colors.white,
//          fontSize: 16.0);
//    } else {
//      Fluttertoast.showToast(
//          msg: item.errorMsg,
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 2,
//          backgroundColor: Colors.blue,
//          textColor: Colors.white,
//          fontSize: 16.0);
//    }
//  }

  Widget buildBanner() {
    return new Container(
      padding: EdgeInsets.all(5),
      child: bannerList.length > 0
          ? new BannerView(
              bannerList.map((bannerItem.BannerData item) {
                return new GestureDetector(
                    onTap: () {
                      NavigatorUtil.toDetails(context, item.url, item.title);
                    },
                    child: new Image.network(
                      item.imagePath,
                      fit: BoxFit.cover,
                    ));
              }).toList(),
              cycleRolling: false,
              autoRolling: true,
              indicatorMargin: 8.0,
              intervalDuration: Duration(seconds: 3),
//              indicatorNormal: this._indicatorItem(Colors.white),
//              indicatorSelected:
//                  this._indicatorItem(Colors.white, selected: true),
//              indicatorBuilder: (context, indicator) {
//                return this._indicatorContainer(indicator);
//              },
              onPageChanged: (index) {
                bannerIndex = index;
              },
            )
          : new Container(),
      width: double.infinity,
      height: 250.0,
    );
  }
}
