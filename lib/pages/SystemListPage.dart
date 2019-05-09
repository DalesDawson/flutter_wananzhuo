import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:flutter_wananzhuo/bean/system_list_item_entity.dart';
import 'package:flutter_wananzhuo/bean/system_tree_entity.dart';
import 'package:flutter_wananzhuo/utils/HttpUtil.dart';
import 'package:flutter_wananzhuo/bean/system_list_item_entity.dart'
    as systemList;

class SystemListPage extends StatefulWidget {
  final List<SystemTreeDatachild> children;
  final String title;
  SystemListPage(this.children, this.title);

  @override
  State<StatefulWidget> createState() {
    return new SystemListPageState(this.children, this.title);
  }
}

class SystemListPageState extends State<SystemListPage> {
  List<SystemTreeDatachild> children;
//  List<SystemListItemDataData> list;
  String titleName;
//  int pageIndex = 0;
//  int cid=0;
  SystemListPageState(this.children, this.titleName);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: children.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(titleName),
            bottom: new TabBar(
              isScrollable: true,
              tabs: children.map((SystemTreeDatachild child) {
                return new Tab(
                  text: child.name,
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
            children: children.map((SystemTreeDatachild child) {
//              new Text(child.id.toString());
              return ListPage(
                cid: child.id,
              );
            }).toList(),
          ),
        ));


  }


//  void getList(int cid) async {
//    var response = await new HttpUtil().getHttp(
//        Api.KNOWLEDGE_LIST + pageIndex.toString() + "/json?" + cid.toString());
//    var item = new systemList.SystemListItemData.fromJson(response);
//    if (pageIndex == 0) {
//      list = item.datas;
//    } else {
//      list.addAll(item.datas);
//    }
//    setState(() {});
//  }

//  Widget buildCustomScrollView() {
//    return new Refresh(
//        onFooterRefresh: onFooterRefresh,
//        onHeaderRefresh: onHeaderRefresh,
//        childBuilder: (BuildContext context,
//            {ScrollController controller, ScrollPhysics physics}) {
//          return new Container(
//              child: new ListView.builder(
//                  physics: physics,
//                  controller: controller,
//                  itemCount: list.length,
//                  itemBuilder: (BuildContext context, int index) {
//                      return buildList(list[index]);
//                  }));
//        });
//  }
//
//  Widget buildList(SystemListItemDataData item) {
//    return new Card(
//      child: new InkWell(
//        onTap: () {
////          Navigator.push(
////              context,
////              new MaterialPageRoute(
////                  builder: (context) =>
////                  new DetailsPage(item.link, item.title)));
//        },
//        child: new ListTile(
//          title: new Row(
//            children: <Widget>[
//              new Text(item.author,
//                  textAlign: TextAlign.left,
//                  style: new TextStyle(color: Colors.grey, fontSize: 13)),
//              new Text(item.niceDate,
//                  textAlign: TextAlign.right,
//                  style: new TextStyle(color: Colors.grey, fontSize: 13))
//            ],
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            crossAxisAlignment: CrossAxisAlignment.center,
//          ),
//          subtitle: new Column(
//            children: <Widget>[
//              new Text(item.title,
//                  textAlign: TextAlign.left,
//                  style: new TextStyle(color: Colors.black, fontSize: 15)),
//              new Text(
//                item.superChapterName + "/" + item.chapterName,
//                style: new TextStyle(color: Colors.blue, fontSize: 13),
//              )
//            ],
//            crossAxisAlignment: CrossAxisAlignment.start,
//          ),
//        ),
//      ),
//    );
//  }
}
class ListPage extends StatefulWidget {
  final int cid;
  const ListPage({Key key, this.cid}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListPageState(cid);
  }
}

class ListPageState extends State<ListPage>  with AutomaticKeepAliveClientMixin {
  final int cid;
  List<SystemListItemDataData> data;
  int pageIndex = 0;
  ListPageState(this.cid);

  @override
  Widget build(BuildContext context) {
    return new Refresh(
        onFooterRefresh: onFooterRefresh,
        onHeaderRefresh: onHeaderRefresh,
        childBuilder: (BuildContext context,
            {ScrollController controller, ScrollPhysics physics}) {
          return new Container(
              child: new ListView.builder(
                physics: physics,
                controller: controller,
                itemCount: data.length,
                itemBuilder:  (BuildContext context, int index) {
//                  data.map((item) {
                    var item=data[index];
                    var date = DateTime.fromMillisecondsSinceEpoch(
                        item.publishTime, isUtc: true);
                    return new GestureDetector(
                      onTap: () {
//            NavigatorUtils.gotoDetail(context, item.link, item.title);
                      },
                      child: new Card(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(item.author, style: new TextStyle(
                                      fontSize: 13.0, color: Colors.grey),),
                                  new Text(
                                    "${date.year}年${date.month}月${date.day}日 ${date
                                        .hour}:${date.minute}",
                                    style: new TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.grey
                                    ),
                                  ),
                                ],
                              ),
                              new Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(item.title, style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0),),
                              ),
                              new Text("${item.author}/${item.chapterName}",
                                style: new TextStyle(fontSize: 13.0, color: Colors.blue),)
                            ],
                          ),
                        ),
                      ),
                    );
//                  }).toList();
                },
              ));
        });

  }
// 顶部刷新
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex = 0;
        data.clear();
        this.getPageData();
      });
    });
  }

// 底部刷新
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex += 1;
        this.getPageData();
      });
    });
  }
  @override
  void initState() {
    super.initState();
    getPageData();
  }

  void getPageData() async {
    print("cid=:"+cid.toString());
    //http://www.wanandroid.com/article/list/0/json?cid=168
    var response = await new HttpUtil().get(
        Api.KNOWLEDGE_LIST + pageIndex.toString() + "/json?cid=" + cid.toString());
    print(response.toString());
    var item = new systemList.SystemListItem.fromJson(response);
    print("返回的数据："+ item.data.datas.toString());
    setState(() {
      if (pageIndex == 0) {
        data = item.data.datas;
      } else {
        data.addAll(item.data.datas);
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


