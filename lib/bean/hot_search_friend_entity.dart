class HotSearchFriend {
	List<HotSearchFriendData> data;
	int errorCode;
	String errorMsg;

	HotSearchFriend({this.data, this.errorCode, this.errorMsg});

	HotSearchFriend.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = new List<HotSearchFriendData>();
			(json['data'] as List).forEach((v) { data.add(new HotSearchFriendData.fromJson(v)); });
		}
		errorCode = json['errorCode'];
		errorMsg = json['errorMsg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
		data['errorCode'] = this.errorCode;
		data['errorMsg'] = this.errorMsg;
		return data;
	}
}

class HotSearchFriendData {
	int visible;
	String icon;
	String link;
	String name;
	int id;
	int order;

	HotSearchFriendData({this.visible, this.icon, this.link, this.name, this.id, this.order});

	HotSearchFriendData.fromJson(Map<String, dynamic> json) {
		visible = json['visible'];
		icon = json['icon'];
		link = json['link'];
		name = json['name'];
		id = json['id'];
		order = json['order'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['visible'] = this.visible;
		data['icon'] = this.icon;
		data['link'] = this.link;
		data['name'] = this.name;
		data['id'] = this.id;
		data['order'] = this.order;
		return data;
	}
}
