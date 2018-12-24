import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/bean/banner_bean.dart';
import 'package:flutter_48_xhdq/bean/shouye_data.dart';
import 'package:flutter_48_xhdq/http/RequestHelper.dart';
import 'package:flutter_48_xhdq/page/news_item_page.dart';
import 'package:flutter_48_xhdq/widget/banner_widget.dart';

class ShouYePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShouYePageState();
  }
}

class _ShouYePageState extends State<ShouYePage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器
  bool isLoading = false; //是否正在加载数据
  bool isLoadMoreEnd = false;
  bool isLoadError = false;
  List<Datum> data = List();
  int page = 1;

  List<BannerBean> banners = [
    BannerBean("http://i2.tiimg.com/669144/ed98254d74687548.png",
        "banner-1"),
    BannerBean(
        "http://i2.tiimg.com/669144/cea7b8ea3c271b92.png",
        "banner-2"),
    BannerBean(
        "http://i2.tiimg.com/669144/94ce3ca81c53fcc8.png",
        "banner-3"),
  ];

  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  void _getMore() {
    if (!isLoading && !isLoadMoreEnd && !isLoadError) {
      isLoading = true;
      page++;
      _getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      child: ListView(
        children: <Widget>[
          //轮播图
          BannerWidget(
            data: banners,
            curve: null,
            duration: 3000,
          ),
          //中国围棋、中国象棋...
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              '热门分类',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.white,
          ),
          GridWidget(),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              '推荐',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.white,
          ),
          ListView.builder(
            physics: new NeverScrollableScrollPhysics(), //禁用滚动
            itemBuilder: buildItem,
            itemCount: data.length,
            shrinkWrap: true,
          ),
        ],
        controller: _scrollController,
      ),
      onRefresh: _onRefresh,
    );
  }

  Future<Null> _onRefresh() async {
    page = 1;
    _getData();
  }

  void _getData() {
    String url =
        "http://8.988lhkj.com/home/qipai/qipaiList?class_id=7&page=$page&pageSize=20&userid=3418&appid=com.whzmhdzi.ckpm";
    RequestHelper.getInstance().postOfJson(url, (data) {
      ShouYeNewsItemBean shouYeNewsItemBean = ShouYeNewsItemBean.fromJson(data);
      if (shouYeNewsItemBean != null &&
          shouYeNewsItemBean.data != null &&
          shouYeNewsItemBean.data.isNotEmpty) {
        if (isLoading) {
          if (shouYeNewsItemBean.data.length < 20) {
            isLoadMoreEnd = true;
          } else {
            isLoading = false;
          }
        }
        upDateUi(shouYeNewsItemBean.data);
      }
    }, (e) {
      if (isLoading) {
        isLoadError = true;
      }
    });
  }

  void upDateUi(List<Datum> mdata) {
    setState(() {
      if (page == 1) data.clear();
      data.addAll(mdata);
    });
  }

  Widget buildItem(BuildContext context, int index) {
    var item = data[index];
    return GestureDetector(
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color(0xff383838),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
            ),
            Image.network(
              item.thumb,
              height: 150,
            ),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.author,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
              padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
            ),
            Container(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.time,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  )),
              padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 10.0),
            )
          ],
        ),
      ),
      //item点击事件
      onTap: () {
        pushNewsDetails(context, item.id);
      },
    );
  }
}

class GridWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GridWidgetState();
  }
}

class _GridWidgetState extends State<GridWidget> {
  List<GridDataOfShouYe> gridDatas = [
    GridDataOfShouYe('./images/icon_sy_zgwq.png', '中国围棋', 2),
    GridDataOfShouYe('./images/icon_sy_zgxq.png', '中国象棋', 3),
    GridDataOfShouYe('./images/icon_sy_gjxq.png', '国际象棋', 4),
    GridDataOfShouYe('./images/icon_sy_gjwq.png', '国际围棋', 5),
    GridDataOfShouYe('./images/icon_sy_qpjq.png', '棋牌技巧', 6),
    GridDataOfShouYe('./images/icon_sy_qpzx.png', '棋牌资讯', 7),
  ];

  List<Widget> buildGridChild() {
    List<Widget> widgetList = List();
    for (int i = 0; i < gridDatas.length; i++) {
      widgetList.add(getItemWidget(gridDatas[i]));
    }
    return widgetList;
  }

  Widget getItemWidget(GridDataOfShouYe gridData) {
    return GestureDetector(
      child: Card(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Image.asset(
                gridData.imgPath,
                height: 60.0,
                width: 60.0,
              ),
              Text(
                gridData.title,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext buildContext) => NewsItemPage(
                      id: gridData.id,
                      title: gridData.title,
                    )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      crossAxisSpacing: 10.0,
      primary: false,
      //列数
      crossAxisCount: 3,
      //禁用滚动
      physics: new NeverScrollableScrollPhysics(),
      //自适应大小
      shrinkWrap: true,
      children: buildGridChild(),
    );
  }
}
