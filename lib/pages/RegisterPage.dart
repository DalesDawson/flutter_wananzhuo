import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:flutter_wananzhuo/bean/user_info_item_entity.dart'
    as UserInfoItem;
import 'package:flutter_wananzhuo/utils/HttpUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: new Text("注册"),
      ),
      body: buildContent(),
      resizeToAvoidBottomPadding: false, //输入框抵住键盘
    );
  }

  Widget buildContent() {
    // TODO: implement build
    return Container(
      decoration: new BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [Colors.blue, Colors.greenAccent])),
      padding: const EdgeInsets.all(55),
      child: Column(
        children: <Widget>[
          Image.network(
            "https://www.wanandroid.com/resources/image/pc/logo.png",
            width: 100,
            height: 100,
          ),
          SizedBox(height: 60),
          new SizedBox(
            child: new Container(
              padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black12,
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: userController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: '用户名',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new SizedBox(
            child: new Container(
              padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black12,
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: passwordController,
                obscureText: true, //是否密码
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: '密码',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new SizedBox(
            child: new Container(
              padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black12,
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: passwordRepeatController,
                obscureText: true, //是否密码
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: '重复密码',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          new GestureDetector(
            child: new Container(
                padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepOrangeAccent,
                ),
                alignment: Alignment.center,
                child: Text(
                  '注册',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      letterSpacing: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            onTap: () {
              if (userController.text.length == 0 ||
                  passwordController.text.length == 0 ||
                  passwordRepeatController.text.length == 0) {
                Fluttertoast.showToast(
                    msg: "用户名或密码不能为空",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 2,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                register(userController.text, passwordController.text,
                    passwordRepeatController.text, context);
              }
            },
          ),
        ],
      ),
    );
  }
}

void register(
    var name, var password, var repassword, BuildContext context) async {
  FormData formData = new FormData.fromMap(
      {"username": name, "password": password, "repassword": repassword});
  var response = await new HttpUtil().post(Api.REGISTER, data: formData);
  var item = new UserInfoItem.UserInfoItem.fromJson(response);
  if (item.errorCode == 0) {
    Fluttertoast.showToast(
        msg: "注册成功！",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.pop(context);
  } else {
    Fluttertoast.showToast(
        msg: item.errorMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
//  bannerList = item.data;
//  setState(() {});
}
////输入用户名
//class InputEditTextNameWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new SizedBox(
//      child: new Container(
//        padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(30),
//          color: Colors.black12,
//        ),
//        alignment: Alignment.center,
//        child: TextField(
//          maxLines: 1,
//          decoration: InputDecoration(
//            hintText: '用户名',
//            border: InputBorder.none,
//          ),
//        ),
//      ),
//    );
//  }
//}

////输入密码
//class InputEditTextPassWordWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new SizedBox(
//      child: new Container(
//        padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(30),
//          color: Colors.black12,
//        ),
//        alignment: Alignment.center,
//        child: TextField(
//          maxLines: 1,
//          decoration: InputDecoration(
//            hintText: '密码',
//            border: InputBorder.none,
//          ),
//        ),
//      ),
//    );
//  }
//}
//
////重复密码
//class InputEditTextPassRepeatWordWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new SizedBox(
//      child: new Container(
//        padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(30),
//          color: Colors.black12,
//        ),
//        alignment: Alignment.center,
//        child: TextField(
//          maxLines: 1,
//          decoration: InputDecoration(
//            hintText: '重复密码',
//            border: InputBorder.none,
//          ),
//        ),
//      ),
//    );
//  }
//}
//
////登录按钮
//class LoginButtonWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new GestureDetector(
//      child: new Container(
//          padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(30),
//            color: Colors.deepOrangeAccent,
//          ),
//          alignment: Alignment.center,
//          child: Text(
//            '登录',
//            textAlign: TextAlign.center,
//            style: TextStyle(
//                letterSpacing: 20,
//                fontWeight: FontWeight.bold,
//                color: Colors.white),
//          )),
//    );
//  }
//}
