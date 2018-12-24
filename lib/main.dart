import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/SplashPage.dart';
import 'package:flutter_jpush/flutter_jpush.dart';

void main() {
  runApp(MaterialApp(
    title: '棋牌快讯',
    theme: ThemeData(primaryColor: Colors.blue),
    home: SplashPage(),
  ));
  _startupJpush();
}
void _startupJpush() async {
  await FlutterJPush.startup();
}
