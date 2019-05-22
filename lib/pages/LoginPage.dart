import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    );
  }

  Widget buildContent() {
//    return new Text("咋个不显示了");
    return new Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "用户名",
                  style: new TextStyle(fontSize: 15),
                ),
                flex: 1,
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 40, maxWidth: 300),
                  child: TextField(
                    controller: userController,
                    cursorColor: Colors.grey, // 光标颜色
                    // 默认设置
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
                        border: new OutlineInputBorder(),
                        hintText: "输入用户名",
                        hintStyle: new TextStyle(
                            fontSize: 14, color: Color.fromARGB(50, 0, 0, 0))),
                    style: new TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                flex: 4,
              ),
            ],
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          new Container(
            margin: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
          ),
          new Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "密码",
                  style: new TextStyle(fontSize: 15),
                ),
                flex: 1,
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 40, maxWidth: 300),
                  child: TextField(
                    controller: userController,
                    cursorColor: Colors.grey, // 光标颜色
                    // 默认设置
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
                        border: new OutlineInputBorder(),
                        hintText: "输入密码",
                        hintStyle: new TextStyle(
                            fontSize: 14, color: Color.fromARGB(50, 0, 0, 0))),
                    style: new TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                flex: 4,
              ),
            ],
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
