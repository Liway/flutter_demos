import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomMultiRenderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomMultiRenderPageState();
  }
}

class _CustomMultiRenderPageState extends State<CustomMultiRenderPage> {
  List customLayoutId = ["0", "1", "2", "3", "4"].toList();

  @override
  Widget build(BuildContext context) {
    double childSize = 66;
    return Scaffold(
      appBar: AppBar(
        title: new Text("CustomMultiPage"),
      ),
      body: new Center(
        child: new Container(
          color: Colors.greenAccent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: CustomMultiChildLayout(
            delegate: CircleLayoutDelegate(customLayoutId,
                childSize: Size(childSize, childSize),
                center: Offset(MediaQuery.of(context).size.width / 2,
                    MediaQuery.of(context).size.width / 2)),
            children: [
              for (var item in customLayoutId)
                new LayoutId(id: item, child: ContentItem(item, childSize))
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        new FlatButton(
            color: Colors.amberAccent,
            onPressed: () {
              setState(() {
                customLayoutId.add("${customLayoutId.length}");
              });
            },
            child: new Text(
              "加",
              style: TextStyle(color: Colors.white),
            )),
        new FlatButton(
          color: Colors.indigoAccent,
          onPressed: () {
            setState(() {
              if (customLayoutId.length > 1) {
                customLayoutId.removeLast();
              }
            });
          },
          child: new Text(
            "减",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}

class CircleLayoutDelegate extends MultiChildLayoutDelegate {
  final List<String> customLayoutId;
  final Offset center;
  Size childSize;

  CircleLayoutDelegate(this.customLayoutId,
      {this.center = Offset.zero, this.childSize});

  @override
  void performLayout(Size size) {
    for (var item in customLayoutId) {
      if (hasChild(item)) {
        double r = 100;
        int index = int.parse(item);
        double step = 360 / customLayoutId.length;
        double hd = (2 * math.pi / 360) * step * index;
        var x = center.dx + math.sin(hd) * r;
        var y = center.dy - math.cos(hd) * r;
        childSize ??= Size(size.width / customLayoutId.length,
            size.height / customLayoutId.length);
        layoutChild(item, BoxConstraints.loose(childSize));
        final double centerX = childSize.width / 2.0;
        final double centerY = childSize.height / 2.0;
        var result = new Offset(x - centerX, y - centerY);
        positionChild(item, result);
      }
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    return false;
  }
}

class ContentItem extends StatelessWidget {
  final String text;
  final double childSize;
  ContentItem(this.text, this.childSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(childSize / 2.0),
      child: InkWell(
        radius: childSize / 2.0,
        customBorder: CircleBorder(),
        onTap: () {},
        child: Container(
          width: childSize,
          height: childSize,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
