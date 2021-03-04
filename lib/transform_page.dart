import 'package:flutter/material.dart';

class TransformPage extends StatelessWidget {
  getHeader(context) {
    return Transform.translate(
      offset: Offset(0, -30),
      child: new Container(
        width: 72.0,
        height: 72.0,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Theme.of(context).cardColor, blurRadius: 40.0)
            ],
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "imgs/gsy_cat.png",
                ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: new Text("TransformPage"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: new Card(
            margin: EdgeInsets.all(20),
            child: Container(
              height: 350,
              padding: EdgeInsets.all(15),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getHeader(context),
                  new Text(
                    "Launching lib/main.dart on iPhone 12 Pro Max "
                    "Launching lib/main.dart on \n iPhone 12 Pro Max"
                    "Launching lib/main.dart on iPhone 12 Pro Max",
                    overflow: TextOverflow.ellipsis,
                    // softWrap: true,
                    maxLines: 10,
                    style: TextStyle(),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
