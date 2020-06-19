import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:path_provider/path_provider.dart';

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;

  static HttpUtil getInstance() {
    print('getInstance');
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

//  StartCallBack startCallBack;
//  ErrorCallBack errorCallBack;
//  SuccessCallBack successCallBack;

  HttpUtil() {
    print('dio赋值');
    // 或者通过传递一个 `options`来创建dio实例
    options = BaseOptions(
      // 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
      baseUrl: Api.HOST,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //表示期望以那种格式(方式)接受响应数据。接受4种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,

      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      receiveTimeout: 3000,
      headers: {},
    );
    dio = new Dio(options);
    dio.interceptors.add(CookieManager(CookieJar()));
//    getCookiePath().then((val) {
//      dio.interceptors
//          .add(CookieManager(PersistCookieJar(dir: val, ignoreExpires: true)));
//    });
  }

  Future<String> getCookiePath() async {
    Directory tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }

  get(url,
      {data,
      options,
      cancelToken,
      errorCallBack,
      successCallBack,
      startCallBack}) async {
    if (startCallBack != null) {
      startCallBack();
    }
    print('get请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.get(
        url,
        cancelToken: cancelToken,
      );
      if (successCallBack != null) {
        successCallBack(response.data);
      }
      print('json结果=${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      }
      if (errorCallBack != null) {
        errorCallBack();
      }
      print('get请求发生错误：$e');
    }
    return response.data;
  }

  postFormData(url, name) async {
    FormData formData = new FormData.fromMap({
      "k": name,
    });
    Response response = await dio.post(url, data: formData);
    print("post-form-data请求返回数据" + response.data.toString());
    return response.data;
  }

  post(url,
      {data,
      options,
      cancelToken,
      errorCallBack,
      successCallBack,
      startCallBack}) async {
    if (startCallBack != null) {
      startCallBack();
    }
    print('post请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      if (successCallBack != null) {
        successCallBack(response.data);
      }
      print('json结果= ${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      if (errorCallBack != null) {
        errorCallBack();
      }
      print('post请求发生错误：$e');
    }
    return response.data;
  }

  postAll(url,
      {data,
      options,
      cancelToken,
      errorCallBack,
      successCallBack,
      startCallBack}) async {
    if (startCallBack != null) {
      startCallBack();
    }
    print('post请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      if (successCallBack != null) {
        successCallBack(response);
      }
      print('json结果= ${response.toString()}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      if (errorCallBack != null) {
        errorCallBack();
      }
      print('post请求发生错误：$e');
    }
    return response;
  }
}

typedef void StartCallBack();

typedef void ErrorCallBack();

typedef void SuccessCallBack(var data);
