import 'package:flutter_wananzhuo/bean/hot_search_friend_entity.dart';
import 'package:flutter_wananzhuo/bean/hot_search_key_entity.dart';
import 'package:flutter_wananzhuo/bean/login_response_entity.dart';
import 'package:flutter_wananzhuo/bean/project_tree_entity.dart';
import 'package:flutter_wananzhuo/bean/system_list_item_entity.dart';
import 'package:flutter_wananzhuo/bean/system_tree_entity.dart';
import 'package:flutter_wananzhuo/bean/user_info_item_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "HotSearchFriend") {
      return HotSearchFriend.fromJson(json) as T;
    } else if (T.toString() == "HotSearchKey") {
      return HotSearchKey.fromJson(json) as T;
    } else if (T.toString() == "LoginResponseEntity") {
      return LoginResponseEntity.fromJson(json) as T;
    } else if (T.toString() == "ProjectTree") {
      return ProjectTree.fromJson(json) as T;
    } else if (T.toString() == "SystemListItem") {
      return SystemListItem.fromJson(json) as T;
    } else if (T.toString() == "SystemTreeEntity") {
      return SystemTreeEntity.fromJson(json) as T;
    } else if (T.toString() == "UserInfoItem") {
      return UserInfoItem.fromJson(json) as T;
    } else {
      return null;
    }
  }
}