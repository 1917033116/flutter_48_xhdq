import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/bean/shouye_data.dart';
import 'package:flutter_48_xhdq/page/news_item_page.dart';

class JiQiaoPage extends StatelessWidget {
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('技巧大厅'),
      ),
      body: Column(
        children: <Widget>[
          Image.network(
              "http://i2.tiimg.com/669144/1d993138a11644c8.jpg"),
          Expanded(
            child: ItemBody(id: 6),
          ),
        ],
      ),
    );
  }
}
