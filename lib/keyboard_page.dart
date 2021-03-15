import 'package:flutter/material.dart';

class KeyBoardPage extends StatefulWidget {
  KeyBoardPage({Key key}) : super(key: key);

  @override
  _KeyBoardPageState createState() => _KeyBoardPageState();
}

class _KeyBoardPageState extends State<KeyBoardPage> {
  bool isKeyboardShowing = false;

  final FocusNode _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return KeyboardDector(
      keyboardShowCallback: (isKeyboardshowing) {
        setState(() {
          this.isKeyboardShowing = isKeyboardshowing;
        });
      },
      content: Scaffold(
        appBar: AppBar(
          title: new Text("keyboardPage"),
        ),
        body: new GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Expanded(
                  child: new Container(
                    alignment: Alignment.center,
                    child: Text(
                      isKeyboardShowing ? "键盘弹起" : "键盘未弹起",
                      style: TextStyle(
                          color: isKeyboardShowing
                              ? Colors.redAccent
                              : Colors.greenAccent),
                    ),
                  ),
                  flex: 2,
                ),
                new Expanded(
                  child: new Center(
                    child: new FlatButton(
                        onPressed: () {
                          if (!isKeyboardShowing) {
                            FocusScope.of(context).requestFocus(_focusNode);
                          }
                        },
                        child: new Text("弹出键盘")),
                  ),
                ),
                new Expanded(
                    flex: 2,
                    child: new Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: new TextField(
                        focusNode: _focusNode,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef KeyboardShowCallback = void Function(bool isKeyboardshowing);

class KeyboardDector extends StatefulWidget {
  final KeyboardShowCallback keyboardShowCallback;
  final Widget content;

  KeyboardDector({this.keyboardShowCallback, @required this.content});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _KeyboardDectorState();
  }
}

class _KeyboardDectorState extends State<KeyboardDector>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        widget.keyboardShowCallback
            .call(MediaQuery.of(context).viewInsets.bottom > 0);
        print("===={MediaQuery.of(context).viewInsets.bottom}");
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.content;
  }
}
