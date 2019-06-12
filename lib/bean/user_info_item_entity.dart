class UserInfoItem {
  UserInfoItemData data;
  int errorCode;
  String errorMsg;

  UserInfoItem({this.data, this.errorCode, this.errorMsg});

  UserInfoItem.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new UserInfoItemData.fromJson(json['data'])
        : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class UserInfoItemData {
  String password;
  List<Null> chapterTops;
  String icon;
  bool admin;
  List<Null> collectIds;
  int id;
  int type;
  String email;
  String token;
  String username;

  UserInfoItemData(
      {this.password,
      this.chapterTops,
      this.icon,
      this.admin,
      this.collectIds,
      this.id,
      this.type,
      this.email,
      this.token,
      this.username});

  UserInfoItemData.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    if (json['chapterTops'] != null) {
      chapterTops = new List<Null>();
    }
    icon = json['icon'];
    admin = json['admin'];
    if (json['collectIds'] != null) {
      collectIds = new List<Null>();
    }
    id = json['id'];
    type = json['type'];
    email = json['email'];
    token = json['token'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    if (this.chapterTops != null) {
      data['chapterTops'] = [];
    }
    data['icon'] = this.icon;
    data['admin'] = this.admin;
    if (this.collectIds != null) {
      data['collectIds'] = [];
    }
    data['id'] = this.id;
    data['type'] = this.type;
    data['email'] = this.email;
    data['token'] = this.token;
    data['username'] = this.username;
    return data;
  }
}
