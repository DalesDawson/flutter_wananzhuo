import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:flutter_wananzhuo/bean/HomeItem.dart' as homeItem;
import 'package:flutter_wananzhuo/bean/project_tree_entity.dart';
import 'package:flutter_wananzhuo/bean/project_tree_entity.dart' as projectTree;
import 'package:flutter_wananzhuo/utils/HttpUtil.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  bool isLoading = true;
  List<ProjectTreeData> projectTreeList;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: projectTreeList.length,
        child: Scaffold(
          appBar: AppBar(
            title: new Text("玩安卓"),
            bottom: new TabBar(
              isScrollable: true,
              tabs: projectTreeList.map((ProjectTreeData child) {
                return new Tab(
                  text: child.name,
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
            children: projectTreeList.map((ProjectTreeData child) {
//              new Text(child.id.toString());
              return ListPage(
                cid: child.id,
              );
            }).toList(),
          ),
        ));
  }

  void getTitle() async {
    var response = await new HttpUtil().get(Api.PROJECT_TREE);
    var item = new projectTree.ProjectTree.fromJson(response);
    setState(() {
      projectTreeList = item.data;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getTitle();
  }
}

class ListPage extends StatefulWidget {
  final int cid;

  const ListPage({Key key, this.cid}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListPageState(cid);
  }
}

class ListPageState extends State<ListPage> with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  final int cid;
  List<homeItem.HomeItemDataData> data = [];
  int pageIndex = 0;

  ListPageState(this.cid);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SpinKitCircle(
            itemBuilder: (_, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey,
                ),
              );
            },
          )
        : new Refresh(
            onFooterRefresh: onFooterRefresh,
            onHeaderRefresh: onHeaderRefresh,
            childBuilder: (BuildContext context,
                {ScrollController controller, ScrollPhysics physics}) {
              return new Container(
                  child: new ListView.builder(
                physics: physics,
                controller: controller,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
//                  data.map((item) {
                  var item = data[index];
                  var date = DateTime.fromMillisecondsSinceEpoch(
                      item.publishTime,
                      isUtc: true);
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
                                new Text(
                                  item.author,
                                  style: new TextStyle(
                                      fontSize: 13.0, color: Colors.grey),
                                ),
                                new Text(
                                  "${date.year}年${date.month}月${date.day}日 ${date.hour}:${date.minute}",
                                  style: new TextStyle(
                                      fontSize: 13.0, color: Colors.grey),
                                ),
                              ],
                            ),
                            new Container(
                                child: new Row(
                              children: <Widget>[
                                Image.network(item.envelopePic,
                                    width: 80, height: 160),
                                Expanded(
                                    child: Text(item.title,
                                        textDirection: TextDirection.ltr,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: new TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0)))
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                            )),
                            new Text(
                              "${item.author}/${item.chapterName}",
                              style: new TextStyle(
                                  fontSize: 13.0, color: Colors.blue),
                            )
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
    isLoading = true;
    getPageData();
  }

  void getPageData() async {
    var response = await new HttpUtil().get(Api.PROJECT_LIST +
        pageIndex.toString() +
        "/json?cid=" +
        cid.toString());
    var item = new homeItem.HomeItem.fromJson(response);
    setState(() {
      isLoading = false;
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
