import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:flutter_wananzhuo/bean/system_tree_entity.dart';
import 'package:flutter_wananzhuo/bean/system_tree_entity.dart' as systemItem;
import 'package:flutter_wananzhuo/utils/HttpUtil.dart';
import 'package:flutter_wananzhuo/utils/NavigatorUtil.dart';

class SystemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  List<systemItem.SystemTreeData> systemList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSystemList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("玩安卓"),
      ),
      body: new Container(
          child: new ListView.builder(
              itemCount: systemList.length,
              itemBuilder: (BuildContext context, int index) {
                return buildList(systemList[index]);
              })),
    );
  }

  void getSystemList() async {
    var response = await new HttpUtil().get(Api.KNOWLEDGE_TREE);
    var item = new systemItem.SystemTreeEntity.fromJson(response);
    systemList = item.data;
    print(systemList);
    setState(() {});
  }

  Widget buildList(SystemTreeData item) {
    return new Card(
      child: new InkWell(
        onTap: () {
          NavigatorUtil.toSystemList(context, item.children, item.name);
        },
        child: new ListTile(
          title: new Row(
            children: <Widget>[
              new Text(item.name,
                  textAlign: TextAlign.left,
                  style: new TextStyle(color: Colors.black, fontSize: 15)),
//              new Text(item.niceDate,
//                  textAlign: TextAlign.right,
//                  style: new TextStyle(color: Colors.grey, fontSize: 13))
            ],
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
//          contentPadding: EdgeInsets.only(left:8,right:0,bottom:0,top: 0),
          subtitle: new Wrap(
            children: <Widget>[
              Wrap(
                spacing: 8.0, // gap between adjacent chips
                runSpacing: 4.0, // gap between lines
                children: item.children.map((data) {
                  return new Container(
                    margin: EdgeInsets.only(
                        left: 0, right: 10.0, bottom: 0, top: 3),
                    child: Text(
                      data.name,
                      style: new TextStyle(color: Colors.grey, fontSize: 13.0),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
