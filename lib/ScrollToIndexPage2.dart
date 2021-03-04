import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class ScrollToIndexPage2 extends StatefulWidget {
  ScrollToIndexPage2({Key key}) : super(key: key);

  @override
  _ScrollToIndexPage2State createState() => _ScrollToIndexPage2State();
}

class _ScrollToIndexPage2State extends State<ScrollToIndexPage2> {
  GlobalKey scrollKey = GlobalKey();

  ScrollController controller = new ScrollController();

  List<ItemModel> dataList = List();

  @override
  void initState() {
    dataList.clear();
    for (int i = 0; i < 100; i++) {
      dataList.add(new ItemModel(i));
    }

    controller.addListener(() {});

    super.initState();
  }

  _scrollToIndex() {
    var key = dataList[12];

    RenderBox renderBox = key.globalKey.currentContext.findRenderObject();

    double dy = renderBox
        .localToGlobal(Offset.zero,
            ancestor: scrollKey.currentContext.findRenderObject())
        .dy;

    var offset = dy + controller.offset;
    print("********$offset");

    controller.animateTo(offset,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("ScrollToIndexPage2"),
      ),
      body: new Container(
        child: SingleChildScrollView(
          key: scrollKey,
          controller: controller,
          child: Column(
            children: dataList.map<Widget>((e) {
              return CardItem(e, key: dataList[e.index].globalKey);
            }).toList(),
          ),
        ),
      ),
      persistentFooterButtons: [
        new FlatButton(
          onPressed: () async {
            _scrollToIndex();
          },
          child: new Text("scroll to 12"),
        )
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  final random = math.Random();

  final ItemModel data;

  CardItem(this.data, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: new Container(
        height: (300 * random.nextDouble()),
        alignment: Alignment.centerLeft,
        child: new Container(
          margin: EdgeInsets.all(5),
          child: new Text("Item ${data.index}"),
        ),
      ),
    );
  }
}

class ItemModel {
  GlobalKey globalKey = new GlobalKey();
  final int index;
  ItemModel(this.index);
}
