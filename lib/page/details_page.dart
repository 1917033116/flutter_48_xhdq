import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/bean/news_details.dart';
import 'package:flutter_48_xhdq/bean/shouye_data.dart';
import 'package:flutter_48_xhdq/db/db_manager.dart';
import 'package:flutter_48_xhdq/http/RequestHelper.dart';
import 'package:flutter_48_xhdq/page/login_page.dart';
import 'package:flutter_48_xhdq/util/baseutil.dart';
import 'package:flutter_48_xhdq/widget/show_progrogress.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class NewsDetailsPage extends StatefulWidget {
  int id;

  NewsDetailsPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewsDetailsPageState();
  }
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  String title = "";
  String content = "";
  String time = "";
  MaterialColor sc = Colors.orange;
  IconData iconSc = Icons.star;
  MaterialColor notSc = Colors.grey;
  IconData iconNotSc = Icons.star_border;
  MaterialColor scColor;
  IconData scIcon;
  DatumDbProvider datumDbProvider;
  Datum curDatum;

  @override
  void initState() {
    super.initState();
    datumDbProvider = DatumDbProvider();
    scColor = notSc;
    scIcon = iconNotSc;
    String url =
        "http://8.988lhkj.com/home/qipai/detail?id=${widget.id}&userid=3418&appid=com.whzmhdzi.ckpm";
    RequestHelper.getInstance().postOfJson(url, (data) {
      NewsDetails newsDetails = NewsDetails.fromJson(data);
      if (newsDetails != null && newsDetails.data != null) {
        var data = newsDetails.data;
        updateUi(data);
        curDatum = Datum(
            id: data.id,
            title: data.title,
            classId: data.classId,
            author: data.author,
            time: data.time,
            thumb: data.thumb);
        DatumDbProviderOfHistry datumDbProviderOfHistry=DatumDbProviderOfHistry();
        datumDbProviderOfHistry.insert(curDatum);
      }
    }, (e) {});
    initSc();
  }

  void updateUi(Data data) {
    setState(() {
      title = data.title;
      content = data.content;
      time = data.time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('详情'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                handleSc();
              },
              icon: Icon(
                scIcon,
                color: scColor,
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: buildItem,
          itemCount: 1,
        ));
  }

  Widget buildItem(BuildContext buildContext, int index) {
    return Column(
      children: <Widget>[getNewsTitle(), getNewsTime(), getNewsContent()],
    );
  }

  Widget getNewsTitle() {
    return Container(
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      padding: EdgeInsets.all(10.0),
    );
  }

  Widget getNewsTime() {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Align(
        child: Text(
          time,
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget getNewsContent() {
    return Html(
      data: content,
      //Optional parameters:
      padding: EdgeInsets.all(8.0),
      onLinkTap: (url) {
        print("Opening $url...");
      },
      customRender: (node, children) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "custom_tag":
              return Column(children: children);
          }
        }
      },
      defaultTextStyle: TextStyle(fontSize: 15, color: Colors.black),
    );
  }

  void initSc() async {
    Datum datum = await datumDbProvider.getDatumInfo(widget.id);
    setState(() {
      if (datum != null) {
        scColor = sc;
        scIcon = iconSc;
      } else {
        scColor = notSc;
        scIcon = iconNotSc;
      }
    });
  }

  void handleSc() async {
    bool isLogin=await SpUtils.getBool(SpUtils.IS_LOGIN);
    if(!isLogin){
      LoginPage.lunchLoginPage(context);
      return;
    }
    Datum datum = await datumDbProvider.getDatumInfo(widget.id);
    if (datum != null) {
      int res = await datumDbProvider.delete(datum);
      if (res != 0) {
        showDialog(context: context,barrierDismissible: true,builder: (BuildContext context)=>ShowProgress(content: '已移除收藏',));
//        ToastUtil.showCenterShort("已移除收藏");
      }
    } else {
      int mres = await datumDbProvider.insert(this.curDatum);
      if (mres != 0) {
        showDialog(context: context,barrierDismissible: true,builder: (BuildContext context)=>ShowProgress(content: '添加收藏成功',));
//        ToastUtil.showCenterShort("添加收藏成功");
      }
    }
    initSc();
  }
}
