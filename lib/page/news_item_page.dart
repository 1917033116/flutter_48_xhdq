import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/bean/shouye_data.dart';
import 'package:flutter_48_xhdq/http/RequestHelper.dart';
import 'package:flutter_48_xhdq/page/details_page.dart';
import 'package:flutter_48_xhdq/util/baseutil.dart';

Widget getItemHavePic(BuildContext context, Datum item) {
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Image.network(
            item.thumb,
            height: 80,
            width: 100,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    item.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xff383838),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        item.author,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text(
                          item.time,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      pushNewsDetails(context, item.id);
    },
  );
}

Widget getItemNoPic(BuildContext context, Datum item) {
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    item.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xff383838),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        item.author,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text(
                          item.time,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      pushNewsDetails(context, item.id);
    },
  );
}

void pushNewsDetails(BuildContext context, int id) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (BuildContext context) => new NewsDetailsPage(id: id)),
  );
}

class NewsItemPage extends StatefulWidget {
  NewsItemPage({Key key, this.id, this.title}) : super(key: key);
  int id;
  String title;

  @override
  State<StatefulWidget> createState() {
    return _NewsItemPageState();
  }
}

class _NewsItemPageState extends State<NewsItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ItemBody(id: widget.id),
    );
  }
}

class ItemBody extends StatefulWidget {
  int id;

  ItemBody({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ItemBodyState();
  }
}

class ItemBodyState extends State<ItemBody> {
  List<Datum> data = List();
  int page = 1;
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isLoadMoreEnd = false;
  bool isLoadError = false;

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if (!isLoading && !isLoadMoreEnd) {
        if (isLoadError) {
          isLoadError = false;
        } else {
          page++;
        }
        getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: _buildItem,
          itemCount: data.length,
          controller: _scrollController,
        ),
        onRefresh: _onRefresh);
  }

  Widget _buildItem(BuildContext buildContext, int index) {
    var item = data[index];
    if (TextUtil.isEmpty(item.thumb)) {
      return getItemNoPic(context, item);
    } else {
      return getItemHavePic(context, item);
    }
  }

  Future<Null> _onRefresh() async {
    page = 1;
    isLoadMoreEnd=false;
    getData();
  }

  void getData() {
    isLoading = true;
    String url =
        "http://8.988lhkj.com/home/qipai/qipaiList?class_id=${widget.id}&page=$page&pageSize=20&userid=3418&appid=com.whzmhdzi.ckpm";
    RequestHelper.getInstance().postOfJson(url, (data) {
      var mdata = ShouYeNewsItemBean.fromJson(data);
      if (mdata != null && mdata.data != null && mdata.data.isNotEmpty) {
        if (isLoading) {
          if (mdata.data.length < 20) {
            isLoadMoreEnd = true;
          }
          isLoading = false;
        }
        updateUi(mdata.data);
      }
    }, (e) {
      if (isLoading) {
        isLoadError = true;
        isLoading = false;
      }
    });
  }

  void updateUi(List<Datum> data) {
    setState(() {
      if (page == 1) this.data.clear();
      this.data.addAll(data);
    });
  }
}
