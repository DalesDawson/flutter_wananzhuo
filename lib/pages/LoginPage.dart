import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/Constant.dart';
import 'package:flutter_wananzhuo/bean/Api.dart';
import 'package:flutter_wananzhuo/bean/login_response_entity.dart';
import 'package:flutter_wananzhuo/pages/RegisterPage.dart';
import 'package:flutter_wananzhuo/utils/HttpUtil.dart';
import 'package:flutter_wananzhuo/utils/SpUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: new Text("登录"),
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
                obscureText: true,
                controller: passwordController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: '密码',
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
                  '登录',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      letterSpacing: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            onTap: () {
              if (userController.text.length == 0 ||
                  passwordController.text.length == 0) {
                Fluttertoast.showToast(
                    msg: "用户名或密码不能为空",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 2,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                Fluttertoast.showToast(
                    msg: "用户名" +
                        userController.text +
                        "密码" +
                        passwordController.text,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 2,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
                login(userController.text, passwordController.text, context);
              }
            },
          ),
          SizedBox(
            height: 15,
          ),
          new GestureDetector(
              child: Container(
                  child: new Text("没有账号,立即注册",
                      style: new TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid))),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new RegisterPage()));
              })
        ],
      ),
    );
  }
}

void login(var name, var password, BuildContext context) async {
  FormData formData =
      new FormData.from({"username": name, "password": password});
  var response = await new HttpUtil().post(Api.LOGIN, data: formData);
  var item = new LoginResponseEntity.fromJson(response);
  if (item.errorCode == 0) {
//    Fluttertoast.showToast(
//        msg: "登录成功！",
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 2,
//        backgroundColor: Colors.black,
//        textColor: Colors.white,
//        fontSize: 16.0);
    _setUser(item.data);

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
}

void _setUser(LoginResponseData user) async {
  SpUtils.setString(Constant.spUserName, user.username);
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
////          controller: userController,
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
//
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
////登录按钮
//class LoginButtonWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new SizedBox(
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
