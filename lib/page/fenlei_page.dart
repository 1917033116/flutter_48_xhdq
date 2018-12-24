import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/bean/shouye_data.dart';
import 'package:flutter_48_xhdq/page/details_page.dart';
import 'package:flutter_48_xhdq/page/news_item_page.dart';

class FeiLeiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeiLeiPageState();
  }
}

class _FeiLeiPageState extends State<FeiLeiPage> {
  List<GridDataOfShouYe> grids = [
    GridDataOfShouYe('./images/icon_sy_zgwq.png', '中国围棋', 2),
    GridDataOfShouYe('./images/icon_sy_zgxq.png', '中国象棋', 3),
    GridDataOfShouYe('./images/icon_sy_gjxq.png', '国际象棋', 4),
    GridDataOfShouYe('./images/icon_sy_gjwq.png', '国际围棋', 5),
    GridDataOfShouYe('./images/icon_sy_qpjq.png', '棋牌技巧', 6),
    GridDataOfShouYe('./images/icon_sy_qpzx.png', '棋牌资讯', 7),
  ];

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: new DefaultTabController(
        length: grids.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: new TabBar(
              isScrollable: true,
              tabs: grids.map((GridDataOfShouYe choice) {
                return new Tab(
                  text: choice.title,
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
            children: grids.map((GridDataOfShouYe choice) {
              return ItemBody(id: choice.id);
            }).toList(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabItem() {
    List<Widget> widgets = List();

    return widgets;
  }
}
