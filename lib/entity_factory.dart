import 'package:flutter_wananzhuo/bean/hot_search_friend_entity.dart';
import 'package:flutter_wananzhuo/bean/hot_search_key_entity.dart';
import 'package:flutter_wananzhuo/bean/system_list_item_entity.dart';
import 'package:flutter_wananzhuo/bean/system_tree_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "HotSearchFriendEntity") {
      return HotSearchFriend.fromJson(json) as T;
    } else if (T.toString() == "HotSearchKey") {
      return HotSearchKey.fromJson(json) as T;
    } else if (T.toString() == "SystemListItem") {
      return SystemListItem.fromJson(json) as T;
    } else if (T.toString() == "SystemTreeEntity") {
      return SystemTreeEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}