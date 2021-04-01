import 'package:flutter/material.dart';

class HeaderAppBar extends StatelessWidget {
  final int alphaBg;
  final bool showStickItem;
  HeaderAppBar({this.alphaBg = 0, this.showStickItem = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double statusBarHeight =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    double reactHeight = 30;

    double containerHeight = kToolbarHeight + statusBarHeight + reactHeight;

    var color = Theme.of(context).primaryColor.withAlpha(alphaBg);

    return new Material(
      color: Colors.transparent,
      child: new Container(
        alignment: Alignment.centerLeft,
        height: containerHeight,
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            new Container(
              height: statusBarHeight,
              color: Colors.red,
            ),
            new Container(
              color: color,
              height: kToolbarHeight,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(125),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      height: kToolbarHeight - 15,
                      margin: EdgeInsets.only(right: 20, left: 20),
                      decoration: BoxDecoration(
                          color: Colors.white.withAlpha(125),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
            showStickItem
                ? Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10),
                    height: reactHeight,
                    color: Colors.amber,
                    child: new Row(
                      children: [
                        new Icon(Icons.ac_unit, color: Colors.white, size: 13),
                        new SizedBox(
                          width: 10,
                        ),
                        new Text(
                          "StickText",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                : new Container()
          ],
        ),
      ),
    );
  }
}
