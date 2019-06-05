import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: new Text("注册"),
      ),
      body: buildContent(),
    );
  }

  Widget buildContent() {
//    return new Text("咋个不显示了");
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
          new InputEditTextNameWidget(),
          SizedBox(
            height: 20,
          ),
          new InputEditTextPassWordWidget(),
          SizedBox(
            height: 20,
          ),
          new InputEditTextPassRepeatWordWidget(),
          SizedBox(
            height: 30,
          ),
          new LoginButtonWidget(),
        ],
      ),
    );
  }
}

//输入用户名
class InputEditTextNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizedBox(
      child: new Container(
        padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black12,
        ),
        alignment: Alignment.center,
        child: TextField(
          maxLines: 1,
          decoration: InputDecoration(
            hintText: '用户名',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

//输入密码
class InputEditTextPassWordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizedBox(
      child: new Container(
        padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black12,
        ),
        alignment: Alignment.center,
        child: TextField(
          maxLines: 1,
          decoration: InputDecoration(
            hintText: '密码',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

//重复密码
class InputEditTextPassRepeatWordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizedBox(
      child: new Container(
        padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black12,
        ),
        alignment: Alignment.center,
        child: TextField(
          maxLines: 1,
          decoration: InputDecoration(
            hintText: '重复密码',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

//登录按钮
class LoginButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizedBox(
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
    );
  }
}
