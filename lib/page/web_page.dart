import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatelessWidget {
  WebPage({Key key, this.url}) : super(key: key);
  String url;

  @override
  Widget build(BuildContext context) {
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, _statusBarHeight, 0.0, 0.0),
      child: new WebviewScaffold(
        url: url,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        scrollBar: false,
      ),
    );
  }
}
