import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/bean/shouye_data.dart';
import 'package:flutter_48_xhdq/db/db_manager.dart';
import 'package:flutter_48_xhdq/page/news_item_page.dart';
import 'package:flutter_48_xhdq/util/baseutil.dart';

class ScanHistry extends StatefulWidget {
  static void push(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ScanHistry()));
  }
  @override
  State<StatefulWidget> createState() {
    return _ScanHistryState();
  }
}

class _ScanHistryState extends State<ScanHistry> {
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
        title: Text('浏览历史'),
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
    List<Datum> list = await DatumDbProviderOfHistry().getAllDatumProvider();
    setState(() {
      datums.addAll(list);
    });
  }
}
