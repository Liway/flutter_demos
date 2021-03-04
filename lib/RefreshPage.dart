import 'package:flutter/material.dart';

class RefreshPage extends StatefulWidget {
  RefreshPage({Key key}) : super(key: key);

  @override
  _RefreshPageState createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {
  final int pageSize = 30;

  bool disposed = false;

  List<String> dataList = List();

  final ScrollController _scrollController = new ScrollController();

  final GlobalKey<RefreshIndicatorState> refreshKey = new GlobalKey();

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    dataList.clear();
    for (int i = 0; i < pageSize; i++) {
      dataList.add("refresh");
    }
    if (disposed) {
      return;
    }

    setState(() {});
  }

  Future<void> loadMore() async {
    await Future.delayed(Duration(seconds: 2));
    for (int i = 0; i < pageSize; i++) {
      dataList.add("loadmore");
    }
    if (disposed) {
      return;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });

    Future.delayed(Duration(seconds: 0), () {
      refreshKey.currentState.show();
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("RefreshPage"),
      ),
      body: Container(
        child: new RefreshIndicator(
          key: refreshKey,
          onRefresh: onRefresh,
          child: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: (dataList.length >= pageSize)
                ? dataList.length + 1
                : dataList.length,
            itemBuilder: (BuildContext context, int index) {
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
            controller: _scrollController,
          ),
        ),
      ),
    );
  }
}
