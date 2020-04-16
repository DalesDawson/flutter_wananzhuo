import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:flutter_wananzhuo/bean/HomeItem.dart' as homeItem;
import 'package:fluttertoast/fluttertoast.dart';

import 'HttpUtil.dart';

class CollectUtil {
  //收藏
  static collect(int id) async {
    var response =
        await new HttpUtil().post(Api.COLLECT + id.toString() + "/json");
    var item = new homeItem.HomeItem.fromJson(response);
    if (item.errorCode == 0) {
      Fluttertoast.showToast(
          msg: "收藏成功！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: item.errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //取消收藏，我的收藏中使用
  static uncollect(int id, int originId) async {
    FormData formData = new FormData.fromMap({
      "originId": originId,
    });
    var response = await new HttpUtil()
        .post(Api.UN_COLLECT + id.toString() + "/json", data: formData);
    var item = new homeItem.HomeItem.fromJson(response);
    if (item.errorCode == 0) {
      Fluttertoast.showToast(
          msg: "取消收藏成功！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: item.errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //取消收藏，文章列表中使用
  static uncollect_originId(int id) async {
    var response = await new HttpUtil()
        .post(Api.UN_COLLECT_ORIGIN_ID + id.toString() + "/json");
    var item = new homeItem.HomeItem.fromJson(response);
    if (item.errorCode == 0) {
      Fluttertoast.showToast(
          msg: "取消收藏成功！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: item.errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
