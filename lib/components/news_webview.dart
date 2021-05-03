import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kliken/components/loader.dart';

class NewsWebView extends StatefulWidget {
  final String url;
  final String title;

  const NewsWebView({Key key, @required this.url, @required this.title})
      : super(key: key);

  @override
  NewsWebViewState createState() {
    return new NewsWebViewState();
  }
}

class NewsWebViewState extends State<NewsWebView> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      initialChild: Center(
        child: Loader(
          dotOneColor: Colors.red,
          dotTwoColor: Colors.orange,
          dotThreeColor: Colors.red,
        ),
      ),
      url: widget.url,
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                widget.url,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
      ),
      withJavascript: true,
      withZoom: true,
      withLocalStorage: true,
      withLocalUrl: true,
    );
  }
}


//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.share),
//            onPressed: () {
//              MaterialPageRoute(
//                  builder: (BuildContext context) {
//                    String _title = widget.title;
//                    String _url = widget.url;
//                    String _description = "Share $_title?";
//                    String _action = "Share!";
//                return AlertDialog(
//                  title: Text("Share Berita .."),
//                  content: SingleChildScrollView(
//                    child: ListBody(
//                      children: <Widget>[
//                        Text(_description),
//                      ],
//                    ),
//                  ),
//                  actions: <Widget>[
//                    FlatButton(
//                      child: Text(
//                        'Batal',
//                        style: TextStyle(color: Colors.black),
//                      ),
//                      onPressed: () {
//                        Navigator.of(context).pop();
//                      },
//                    ),
//                    RaisedButton(
//                      color: Colors.orange,
//                      child: Text(
//                        _action,
//                        style: TextStyle(color: Colors.white),
//                      ),
//                      onPressed: () {
//                        Navigator.of(context).pop();
//                      },
//                    ),
//                  ],
//                );
//              });
//              String title = 'Share Berita Ini?';
//              String description = 'Share berita ke ...';
//              String action = 'Share';
//              var onYes = () {
//                print("Share News");
//              };
//              var onNo = () {
//                //Cancel
//              };
//              confirmDialog(context, onYes, onNo, title, description, action);
//            },
//          ),
//        ],