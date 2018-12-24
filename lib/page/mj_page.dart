import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/page/fenlei_page.dart';
import 'package:flutter_48_xhdq/page/jiqiao_page.dart';
import 'package:flutter_48_xhdq/page/shouye_page.dart';
import 'package:flutter_48_xhdq/page/user_center.dart';

///Mj首页
class MjPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MjPageState();
}

class _MjPageState extends State<MjPage> {
  int _selectedIndex = 0;
  final titles=["首页","分类","技巧","个人中心"];

  final _widgetOptions = [
    ShouYePage(),
    FeiLeiPage(),
    JiQiaoPage(),
    UserCenterPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text(titles[0])),
          BottomNavigationBarItem(
              icon: Icon(Icons.dehaze), title: Text(titles[1])),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_library), title: Text(titles[2])),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity), title: Text(titles[3])),
        ],
        currentIndex: _selectedIndex,
        //设置显示的模式
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
