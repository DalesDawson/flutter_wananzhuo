# 1.数据的上拉加载更多和下拉刷新
解决：flutter_refresh: ^0.0.2

# 2.数据还没加载出来，界面报红色错误
解决：用一个变量控制是否在加载完成，未加载完成先显示加载页面

# 3.webview控件加载不出有些网页（报错：net err_cleartext_not_permitted）
从Android 9.0（API级别28）开始，默认情况下禁用明文支持。因此http的url均无法在webview中加载
解决：
```
<?xml version="1.0" encoding="utf-8"?>
   <manifest ...>
       <uses-permission android:name="android.permission.INTERNET" />
       <application
           ...
           android:usesCleartextTraffic="true"
           ...>
           ...
       </application>
   </manifest>
```

# 4.Container加不了点击事件
解决：外面套一层GestureDetector
```
onTap: () {
Navigator.push(context,new MaterialPageRoute(
builder: (context) =>
new DetailsPage(item.link, item.name)));
});
```

# 5.搜索需要使用的库packages:
[搜索地址](https://pub.flutter-io.cn/flutter)