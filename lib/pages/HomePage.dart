import 'package:flutter/material.dart';

import 'package:flutter_wananzhuo/bean/BannerItem.dart' as bannerItem;
import 'package:flutter_wananzhuo/bean/HomeItem.dart' as homeItem;
import 'package:banner_view/banner_view.dart';
import 'package:flutter_wananzhuo/utils/HttpUtil.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:flutter_wananzhuo/pages/DetailsPage.dart';
import 'package:flutter_refresh/flutter_refresh.dart';

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
      homeList.addAll(item.data.datas);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: buildCustomScrollView());
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
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      new DetailsPage(item.link, item.title)));
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

  Widget buildBanner() {
    return new Container(
      child: bannerList.length > 0
          ? new BannerView(
              bannerList.map((bannerItem.BannerData item) {
                return new GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  new DetailsPage(item.url, item.title)));
                    },
                    child: new Image.network(
                      item.imagePath,
                      fit: BoxFit.cover,
                    ));
              }).toList(),
              cycleRolling: false,
              autoRolling: true,
              indicatorMargin: 8.0,
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
      height: 200.0,
    );
  }
}
