import 'package:flutter/material.dart';

class MineDemo extends StatelessWidget {
  const MineDemo({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
      ),
      body: new Column(
        children: [
          _SettingItem(
            iconData: Icons.notifications,
            iconColor: Colors.blue,
            title: '消息中心',
            suffix: _NotificationText(
              text: '2',
            ),
          ),
          Divider(),
          _SettingItem(
            iconData: Icons.thumb_up,
            iconColor: Colors.green,
            title: '我赞过得',
            suffix: _Suffix(
              text: '121篇',
            ),
          ),
          Divider(),
          _SettingItem(
            iconData: Icons.grade,
            iconColor: Colors.yellow,
            title: '收藏集',
            suffix: _Suffix(
              text: '2个',
            ),
          ),
          Divider(),
          _SettingItem(
            iconData: Icons.shopping_basket,
            iconColor: Colors.yellow,
            title: '已购小册子',
            suffix: _Suffix(text: '100个'),
          )
        ],
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem(
      {Key key, this.iconColor, this.iconData, this.title, this.suffix})
      : super(key: key);

  final IconData iconData;
  final Color iconColor;
  final String title;
  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Row(
        children: [
          SizedBox(
            width: 30,
          ),
          Icon(iconData, color: iconColor),
          SizedBox(
            width: 10,
          ),
          Expanded(child: Text("$title")),
          suffix,
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}

class _NotificationText extends StatelessWidget {
  final String text;

  const _NotificationText({Key key, this.text}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.red),
      child: Text(
        '$text',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _Suffix extends StatelessWidget {
  final String text;

  const _Suffix({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(color: Colors.grey.withOpacity(0.6)),
    );
  }
}
