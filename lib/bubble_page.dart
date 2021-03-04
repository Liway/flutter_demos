import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demos/bubble_paint.dart';
import 'package:flutter_demos/bubble_tip_widget.dart';

class BubblePage extends StatelessWidget {
  final double bubbleHeight = 60;
  final double bubbleWidth = 120;
  final GlobalKey contentKey = GlobalKey();

  final GlobalKey button1Key = GlobalKey();
  final GlobalKey button2Key = GlobalKey();
  final GlobalKey button3Key = GlobalKey();
  final GlobalKey button4Key = GlobalKey();

  getX(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    double dx = renderBox.localToGlobal(Offset.zero).dx;
    return dx;
  }

  getY(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    double dy = renderBox.localToGlobal(Offset.zero).dy;
    return dy;
  }

  getWidth(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    return renderBox.size.width;
  }

  getHeight(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  bool isClient() {
    try {
      return Platform.isAndroid == true || Platform.isIOS == true;
    } catch (e) {
      return false;
    }
  }

  getY1() {
    if (isClient()) {
      return getY(button1Key) +
          getHeight(button1Key) -
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    } else {
      return getY(button1Key) + getHeight(button1Key);
    }
  }

  getY2() {
    if (isClient()) {
      return getY(button2Key) +
          getHeight(button2Key) / 2 -
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    } else {
      return getY(button2Key) + getHeight(button2Key) / 2;
    }
  }

  getY3() {
    if (isClient()) {
      return getY(button3Key) +
          getHeight(button3Key) / 2 -
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    } else {
      return getY(button3Key) + getHeight(button3Key);
    }
  }

  getY4() {
    if (isClient()) {
      return getY(button4Key) -
          bubbleHeight -
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    } else {
      return getY(button4Key) - bubbleHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("BubblePage"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(15),
        child: new Stack(
          key: contentKey,
          children: [
            new MaterialButton(
              key: button1Key,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return MaterialButton(
                        color: Colors.red,
                        onPressed: () {},
                      );
                      // return BubbleDialog(
                      //   "Text1",
                      //   height: bubbleHeight,
                      //   width: bubbleWidth,
                      //   arrowLocation: ArrowLocation.TOP,
                      //   x: getX(button1Key) + getWidth(button1Key) / 2,
                      //   y: getY1(),
                      // );
                    });
              },
              color: Colors.blue,
            ),
            new Positioned(
              child: new MaterialButton(
                key: button2Key,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BubbleDialog(
                          "Text2",
                          height: bubbleHeight,
                          width: bubbleWidth,
                          arrowLocation: ArrowLocation.RIGHT,
                          x: getX(button2Key) - bubbleWidth,
                          y: getY2(),
                        );
                      });
                },
                color: Colors.greenAccent,
              ),
              left: MediaQuery.of(context).size.width / 2,
            ),
            new Positioned(
              child: new MaterialButton(
                key: button3Key,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BubbleDialog(
                          "Text4",
                          height: bubbleHeight,
                          width: bubbleWidth,
                          arrowLocation: ArrowLocation.LEFT,
                          x: getX(button3Key) + getWidth(button3Key),
                          y: getY3(),
                        );
                      });
                },
                color: Colors.yellow,
              ),
              left: MediaQuery.of(context).size.width / 5,
              top: MediaQuery.of(context).size.height / 4 * 3,
            ),
            new Positioned(
              child: new MaterialButton(
                key: button4Key,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BubbleDialog(
                          "Text4",
                          height: bubbleHeight,
                          width: bubbleWidth,
                          arrowLocation: ArrowLocation.BOTTOM,
                          x: getX(button4Key) + getWidth(button4Key) / 2,
                          y: getY4(),
                        );
                      });
                },
                color: Colors.redAccent,
              ),
              left: MediaQuery.of(context).size.width / 2 -
                  Theme.of(context).buttonTheme.minWidth / 2,
              top: MediaQuery.of(context).size.height / 2 -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight,
            )
          ],
        ),
      ),
    );
  }
}

class BubbleDialog extends StatelessWidget {
  final String text;

  final ArrowLocation arrowLocation;

  final double height;

  final double width;

  final double radius;

  final double x;

  final double y;

  final VoidCallback voidcallback;

  BubbleDialog(this.text,
      {this.arrowLocation = ArrowLocation.BOTTOM,
      this.height,
      this.width,
      this.radius = 4,
      this.x,
      this.y,
      this.voidcallback});

  confirm(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build\
    print("$arrowLocation ==$height === $width == $radius == $x == $y == ");
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          confirm(context);
        },
        child: Container(
          alignment: Alignment.centerLeft,
          child: BubbleTipWidget(
            arrowLocation: arrowLocation,
            width: width,
            height: height,
            radius: radius,
            x: x,
            y: y,
            text: text,
            voidCallback: () {
              confirm(context);
            },
          ),
        ),
      ),
    );
  }
}
