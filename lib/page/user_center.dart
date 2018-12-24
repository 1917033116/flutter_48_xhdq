import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/db/db_manager.dart';
import 'package:flutter_48_xhdq/db/user.dart';
import 'package:flutter_48_xhdq/page/login_page.dart';
import 'package:flutter_48_xhdq/page/scan_page.dart';
import 'package:flutter_48_xhdq/page/shoucang_page.dart';
import 'package:flutter_48_xhdq/util/baseutil.dart';
import 'package:flutter_48_xhdq/widget/show_progrogress.dart';
import 'package:flutter_plugin_system/flutter_plugin_system.dart';

final String LOGIN_REGISTER = '登录/注册';
final String LOGIN_OUT = '退出登录';
final String NOT_LOGIN = '未登录';

class UserCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: PartOfTop(),
    );
  }
}

class PartOfTop extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PartOfTopState();
  }
}

class _PartOfTopState extends State<PartOfTop> {
  String lrButtonStr = LOGIN_REGISTER;

  String nickName = NOT_LOGIN;
  String cacheSize = "0M";

  @override
  void initState() {
    super.initState();
    isLogined();
    getCacheSize();
  }

  void isLogined() async {
    bool isLogin = await SpUtils.getBool(SpUtils.IS_LOGIN);

    if (isLogin) {
      nickName = await SpUtils.getString(SpUtils.NICK_NAME);
      if (TextUtil.isEmpty(nickName)) {
        nickName = NOT_LOGIN;
      }
      lrButtonStr = LOGIN_OUT;
    } else {
      nickName = NOT_LOGIN;
      lrButtonStr = LOGIN_REGISTER;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.black,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  textColor: Colors.white,
                  child: Text(lrButtonStr),
                  color: Color(0x55585858),
                  onPressed: _clickLoginRegister,
                ),
              ),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    //圆形控件
                    backgroundColor: Colors.white,
                    child: Text(
                      nickName[0],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      textColor: Colors.white,
                      child: Text(nickName),
                      color: Color(0x55585858),
                      onPressed: () {
                        if (nickName == NOT_LOGIN) {
                          _clickLoginRegister();
                        } else
                          showDialog1(context);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  getShouCangHistry(
                      './images/user_shoucang.png', '我的收藏', clickShouCang),
                  getShouCangHistry(
                      './images/liulang_lishi.png', '浏览历史', clickHistry),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey,
          height: 10.0,
        ),
        getItem('./images/gengxin.png', '检查更新', true, clickUpdate),
        getLine(),
        getItem('./images/qingchuhc.png', '清除缓存 $cacheSize', false, clickClear),
        getLine(),
//        getItem('./images/fenxiang.png', '应用分享', false, clickShare),
      ],
    );
  }

  ///点击清除缓存
  void clickClear() {
    var dialog = AlertDialog(
      title: Text('修改昵称'),
      content: Text('确定要清除缓存吗？'),
      actions: <Widget>[
        FlatButton(
          child: Text('确定'),
          onPressed: () {
           clearCache();
           Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('取消'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    showDialog(context: context,builder: (BuildContext context)=>dialog);
  }

  ///点击应用分享
  void clickShare() {}

  ///点击检查更新
  void clickUpdate() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => ShowProgress(
              content: '已是最新版本',
            ));
  }

  ///点击'我的收藏'
  void clickShouCang() {
    ShouCangPage.push(context);
  }

  ///点击'浏览历史'
  void clickHistry() {
    ScanHistry.push(context);
  }

  ///点击登录注册按钮
  void _clickLoginRegister() async {
    if (LOGIN_REGISTER == lrButtonStr) {
      //跳转到登录页面
      bool result = await LoginPage.lunchLoginPage(context);
      await SpUtils.addBool(SpUtils.IS_LOGIN, result);
      isLogined();
    } else {
      await SpUtils.addBool(SpUtils.IS_LOGIN, false);
      isLogined();

      ToastUtil.showCenterShort('成功退出登录');
    }
  }

  ///‘我得收藏’或‘浏览历史’
  Widget getShouCangHistry(String imgPath, String tabName, onPressed()) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: RaisedButton(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          color: Color(0x55585858),
          onPressed: onPressed,
          child: Column(
            children: <Widget>[
              Image.asset(
//                './images/user_shoucang.png',
                imgPath,
                width: 40.0,
                height: 35.0,
              ),
              Text(
//                '我的收藏',
                tabName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              )
            ],
          ),
        ),
      ),
      flex: 1,
    );
  }

  Widget getLine() {
    return Container(
      color: Color(0xffefefef),
      height: 1.0,
    );
  }

  Widget getItem(String imgPath, String tabName, bool moreVis, onClick()) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Image.asset(
              imgPath,
              height: 30.0,
              width: 30.0,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Align(
                  child: Text(tabName),
                  alignment: Alignment.centerLeft,
                ),
              ),
              flex: 1,
            ),
            Offstage(
              //是否隐藏：true隐藏
              offstage: moreVis,
              child: Image.asset(
                './images/icon_more_lager.png',
                height: 25.0,
                width: 25.0,
              ),
            ),
          ],
        ),
      ),
      onTap: onClick,
    );
  }

  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);

  void showDialog1(BuildContext context) {
    var controller = TextEditingController();

    var dialog = AlertDialog(
      title: Text('修改昵称'),
      content: TextField(
        style: hintTips,
        controller: controller,
        decoration: InputDecoration(
            hintText: '请输入昵称', prefixIcon: Icon(Icons.account_circle)),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('确定'),
          onPressed: () {
            amendNickName(context, controller);
          },
        ),
        FlatButton(
          child: Text('取消'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => dialog);
  }

  void amendNickName(
      BuildContext context, TextEditingController controller) async {
    String inputName = controller.text.trim();
    if (TextUtil.isEmpty(inputName)) {
      ToastUtil.showCenterShort('昵称不能为空');
      return;
    }
    String userName = await SpUtils.getString(SpUtils.USER_ACCOUNT);
    DemoUserInfoDbProvider provider = DemoUserInfoDbProvider();
    User user = await provider.getUserInfo(userName);
    nickName = inputName;
    await provider.insert(userName, user.pwd, inputName);
    await SpUtils.addString(SpUtils.NICK_NAME, inputName);
    Navigator.pop(context);
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => ShowProgress(
              content: '修改成功',
            ));
    isLogined();
  }

  void getCacheSize() async {
   var mcacheSize = await FlutterPluginSystem.getCacheSize();
    setState(() {
      cacheSize=mcacheSize;
    });
  }

  void clearCache() async{
   bool isClear=await FlutterPluginSystem.clearCache();
   if(isClear){
     ToastUtil.showCenterShort('已清除缓存');
     getCacheSize();
   }
  }
}
