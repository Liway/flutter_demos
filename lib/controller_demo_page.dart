import 'package:flutter/material.dart';

class ControllerDemoPage extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("ControllerDemoPage"),
      ),
      body: new Container(
        margin: EdgeInsets.all(10),
        child: new Center(
          child: new TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: "请输入文本",
                hintStyle: TextStyle(fontSize: 15, color: Colors.red)),
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.text = "Changed by FloatingActionButton";
        },
        child: new Text("C"),
      ),
    );
  }
}
