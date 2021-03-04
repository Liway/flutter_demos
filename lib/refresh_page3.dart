import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as IOS;
import 'gsy_refresh_sliver.dart';
import 'dart:math';

class RefreshPage3 extends StatefulWidget {
  RefreshPage3({Key key}) : super(key: key);

  @override
  _RefreshPage3State createState() => _RefreshPage3State();
}

class _RefreshPage3State extends State<RefreshPage3> {
  final GlobalKey<CupertinoSliverRefreshControlState> sliverRefreshKey =
      GlobalKey<CupertinoSliverRefreshControlState>();

  final int pageSize = 30;

  bool disposed = false;

  List<String> dataList = new List();

  final ScrollController _scrollController = ScrollController();

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    dataList.clear();
    for (var i = 0; i < pageSize; i++) {
      dataList.add("refresh");
    }
    if (disposed) {
      return;
    }

    setState(() {});
  }

  Future<void> loadMore() async {
    await Future.delayed(Duration(seconds: 2));
    for (var i = 0; i < pageSize; i++) {
      dataList.add("loadMore");
    }
    if (disposed) {
      return;
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.animateTo(-141,
          duration: Duration(milliseconds: 500), curve: Curves.linear);
      return true;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("RefreshPage"),
      ),
      body: Container(
        child: new NotificationListener(
            onNotification: (ScrollNotification notification) {
              sliverRefreshKey.currentState
                  .notifyScrollNotification(notification);
              if (notification is ScrollEndNotification) {
                if (_scrollController.position.pixels > 0 &&
                    _scrollController.position.pixels ==
                        _scrollController.position.maxScrollExtent) {
                  loadMore();
                }
              }
              return false;
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: <Widget>[
                CupertinoSliverRefreshControl(
                  key: sliverRefreshKey,
                  onRefresh: onRefresh,
                  builder: buildSimpleRefreshIndicator,
                ),
                SliverSafeArea(
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (index == dataList.length) {
                          return new Container(
                            margin: EdgeInsets.all(10),
                            child: Align(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return Card(
                          child: new Container(
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: new Text("Item ${dataList[index]} $index"),
                          ),
                        );
                      },
                      childCount: (dataList.length >= pageSize)
                          ? dataList.length + 1
                          : dataList.length,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

Widget buildSimpleRefreshIndicator(
  BuildContext context,
  RefreshIndicatorMode refreshState,
  double pulledExtent,
  double refreshTriggerPullDistance,
  double refreshIndicatorExtent,
) {
  const Curve opacityCurve = Interval(0.4, 0.8, curve: Curves.easeInOut);
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: refreshState != RefreshIndicatorMode.refresh
          ? Opacity(
              opacity: opacityCurve.transform(
                  min(pulledExtent / refreshTriggerPullDistance, 1.0)),
              child: const Icon(
                IOS.CupertinoIcons.down_arrow,
                color: IOS.CupertinoColors.inactiveGray,
                size: 36.0,
              ),
            )
          : Opacity(
              opacity: opacityCurve
                  .transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
              child: const IOS.CupertinoActivityIndicator(radius: 14.0),
            ),
    ),
  );
}
