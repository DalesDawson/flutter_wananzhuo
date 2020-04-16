class BaseResponse {
  dynamic data;
  int errorCode;
  String errorMsg;

  BaseResponse({this.data, this.errorCode, this.errorMsg});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new BaseResponse.fromJson(json['data']) : null;
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
