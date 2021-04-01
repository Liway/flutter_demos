import 'package:flutter/material.dart';

class FlowPopMenu extends StatefulWidget {
  FlowPopMenu({Key key}) : super(key: key);

  @override
  _FlowPopMenuState createState() => _FlowPopMenuState();
}

class _FlowPopMenuState extends State<FlowPopMenu>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  IconData lastTapped = Icons.notifications;
  final List<IconData> menuItems = [
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    Icons.menu
  ];

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() {
        lastTapped = icon;
      });
    } else {
      animationController.status == AnimationStatus.completed
          ? animationController.reverse()
          : animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
  }

  Widget flowMenuItem(IconData icon) {
    final double buttonWH =
        MediaQuery.of(context).size.width * 2 / (menuItems.length * 3);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RawMaterialButton(
        fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue,
        splashColor: Colors.amber[100],
        shape: CircleBorder(),
        constraints: BoxConstraints.tight(Size(buttonWH, buttonWH)),
        onPressed: () {
          _updateMenu(icon);
        },
        child: Icon(icon, color: Colors.white, size: 30.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("popMenu"),
      ),
      body: new Center(
        child: Flow(
          delegate: FlowMenuDelegate(animation: animationController),
          children: menuItems.map((e) => flowMenuItem(e)).toList(),
        ),
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> animation;
  FlowMenuDelegate({this.animation}) : super(repaint: animation);
  @override
  void paintChildren(FlowPaintingContext context) {
    double x = 50.0;
    double y = 50.0;
    for (var i = 0; i < context.childCount; ++i) {
      x = context.getChildSize(i).width * i * animation.value;
      print("=====${animation.value}");
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowMenuDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    animation != oldDelegate.animation;
  }
}
