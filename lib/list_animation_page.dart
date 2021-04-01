import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'header_app_bar.dart';

class ListAnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListAnimationPageState();
  }
}

class _ListAnimationPageState extends State<ListAnimationPage> {
  int appBarColorAlpha = 0;
  double scrollPix = 0;
  bool showStickItem = false;
  double headerHeight = 300;
  double headerRectMargin = 40;
  double headerRectHeight = 60;

  _buildHeader() {
    double statusBarHeight =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    double dynamicValue =
        headerHeight - headerRectHeight - kToolbarHeight - statusBarHeight;
    double marginEdge = 0;
    if (scrollPix >= dynamicValue) {
      marginEdge = 10 - (scrollPix - dynamicValue);
      marginEdge = math.max(0, marginEdge);
      if (marginEdge == 0) {
        showStickItem = true;
      } else {
        showStickItem = false;
      }
    } else {
      marginEdge = 10;
      showStickItem = false;
    }

    return Container(
      alignment: Alignment.topCenter,
      height: headerHeight,
      child: new Stack(
        children: [
          new Image.asset(
            "imgs/gsy_cat.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: headerHeight - headerRectMargin,
          ),
          new Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: headerRectHeight,
              color: Colors.amber,
              margin: EdgeInsets.only(left: marginEdge, right: marginEdge),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  new Text("StickText",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  new Expanded(child: new Container()),
                  new Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _handleScrollUpdateNotification(ScrollUpdateNotification notification) {
    scrollPix = notification.metrics.pixels;
    var curAlpha = 0;
    if (notification.metrics.pixels <= 0) {
      curAlpha = 0;
    } else {
      curAlpha = ((notification.metrics.pixels / 180) * 255).toInt();
      if (curAlpha > 255) {
        curAlpha = 255;
      }
    }

    setState(() {
      appBarColorAlpha = curAlpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: [
        Scaffold(
          body: MediaQuery.removePadding(
            context: context,
            removeLeft: true,
            removeRight: true,
            removeBottom: true,
            removeTop: true,
            child: Container(
              child: new NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification) {
                    _handleScrollUpdateNotification(notification);
                  }
                  return false;
                },
                child: new ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildHeader();
                    }
                    return Card(
                      child: new Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: new Text("Item ${(index)}"),
                      ),
                    );
                  },
                  itemCount: 50,
                ),
              ),
            ),
          ),
        ),
        HeaderAppBar(
          alphaBg: appBarColorAlpha,
          showStickItem: showStickItem,
        )
      ],
    );
  }
}
