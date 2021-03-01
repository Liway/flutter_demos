import 'package:flutter/material.dart';
import 'controller_demo_page.dart';
import 'clip_Image.dart';
import 'scroll_listener_page.dart';
import 'scroll_to_index_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
      routes: routers,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var routeLIsts = routers.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        child: new ListView.builder(
          itemBuilder: (context, index) {
            return new InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(routeLIsts[index]);
              },
              child: new Card(
                margin: EdgeInsets.all(10),
                child: new Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  child: new Text(routeLIsts[index]),
                ),
              ),
            );
          },
          itemCount: routers.length,
        ),
      ),
    );
  }
}

Map<String, WidgetBuilder> routers = {
  "文本框输入": (BuildContext context) {
    return new ControllerDemoPage();
  },
  "不同组合实现圆角": (context) {
    return new ClipImagePage();
  },
  "列表滑动监听": (context) {
    return new ScrollListenerPage();
  },
  "滑动到指定位置": (context) {
    return new ScrollToIndexPage();
  }
};
