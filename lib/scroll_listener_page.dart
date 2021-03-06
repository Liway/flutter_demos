import 'package:flutter/material.dart';

class ScrollListenerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScrollListenerPage();
  }
}

class _ScrollListenerPage extends State<ScrollListenerPage> {
  final ScrollController _scrollController = new ScrollController();

  bool isEnd = false;

  double offset = 0;

  String notify = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset;
        isEnd = _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("ScrollListenerPage"),
      ),
      body: new Container(
        child: NotificationListener(
          onNotification: (notification) {
            String notify = '';
            if (notification is ScrollEndNotification) {
              notify = "ScrollEnd";
            } else if (notification is ScrollStartNotification) {
              notify = "ScrollStart";
            } else if (notification is ScrollUpdateNotification) {
              notify = "ScrollUpdate";
            }
            setState(() {
              this.notify = notify;
            });
            return false;
          },
          child: new ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              return Card(
                child: new Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  child: new Text("Item $index"),
                ),
              );
            },
            itemCount: 100,
          ),
        ),
      ),
      persistentFooterButtons: [
        new FlatButton(
          onPressed: () {
            _scrollController.animateTo(0,
                duration: Duration(seconds: 1), curve: Curves.bounceInOut);
          },
          child: new Text("position: ${offset.floor()}"),
        ),
        new Container(
          width: 0.3,
          height: 30.0,
        ),
        new FlatButton(
          onPressed: () {},
          child: new Text(notify),
        ),
        new Visibility(
          visible: isEnd,
          child: new FlatButton(
            onPressed: () {},
            child: new Text("到达底部"),
          ),
        ),
      ],
    );
  }
}
