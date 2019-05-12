import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/bean/system_tree_entity.dart';
import 'package:flutter_wananzhuo/pages/DetailsPage.dart';
import 'package:flutter_wananzhuo/pages/SearchResultPage.dart';
import 'package:flutter_wananzhuo/pages/SystemListPage.dart';

class NavigatorUtil{
  ///替换
  static void pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  ///切换无参数页面
  static void pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  ///详情页面
  static void toDetails(BuildContext context, String url, String title) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new DetailsPage(url, title)));
  }

  ///体系列表页面
  static void toSystemList(
      BuildContext context, List<SystemTreeDatachild> list, String title) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new SystemListPage(list, title)));
  }

  ///搜索结果页面
  static void toSearchResult(BuildContext context, String key) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new SearchResultPage(key)));
  }
}
