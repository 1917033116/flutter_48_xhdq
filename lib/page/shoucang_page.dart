import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/bean/shouye_data.dart';
import 'package:flutter_48_xhdq/db/db_manager.dart';
import 'package:flutter_48_xhdq/page/news_item_page.dart';
import 'package:flutter_48_xhdq/util/baseutil.dart';

class ShouCangPage extends StatefulWidget {
  static void push(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => ShouCangPage()));
  }

  @override
  State<StatefulWidget> createState() {
    return _ShouYePageState();
  }
}

class _ShouYePageState extends State<ShouCangPage> {
  List<Datum> datums = List();

  @override
  void initState() {
    super.initState();
    getDatums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的收藏'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      child: ListView.builder(
        itemBuilder: _buidItem,
        itemCount: datums.length,
      ),
    );
  }

  Widget _buidItem(BuildContext context, int index) {
    Datum datum = datums[index];
    if (TextUtil.isEmpty(datum.thumb)) {
      return getItemNoPic(context, datum);
    }
    return getItemHavePic(context, datum);
  }

  void getDatums() async {
    List<Datum> list = await DatumDbProvider().getAllDatumProvider();
    setState(() {
      datums.addAll(list);
    });
  }
}
