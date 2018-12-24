import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/db/db_manager.dart';
import 'package:flutter_48_xhdq/db/user.dart';
import 'package:flutter_48_xhdq/page/register_page.dart';
import 'package:flutter_48_xhdq/util/baseutil.dart';
import 'package:flutter_48_xhdq/widget/show_progrogress.dart';

class LoginPage extends StatelessWidget {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  var _userNameController = TextEditingController();
  var _userPassController = TextEditingController();

  static Future<bool> lunchLoginPage(BuildContext context) async =>
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext buildContext) => LoginPage()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('登录'),
        ),
        body: ListView(
          children: <Widget>[
            getRegisterLoginRow(
                _userNameController, "请输入账号", Icon(Icons.account_box), false),
            getRegisterLoginRow(
                _userPassController, "请输入密码", Icon(Icons.lock), true),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.fromLTRB(leftRightPadding, 30.0, 5.0, 0.0),
                    color: Colors.blue,
                    child: FlatButton(
                      onPressed: () {
                        _login(context);
                      },
                      child: Text(
                        '登录',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.fromLTRB(5.0, 30.0, leftRightPadding, 0.0),
                    color: Color(0xffefefef),
                    child: FlatButton(
                      onPressed: () {
                        RegisterPage.pushPage(context);
                      },
                      child: Text(
                        '注册',
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  void _login(BuildContext context) async {
    String userName = _userNameController.text;
    String pwd = _userPassController.text;
    if (TextUtil.isEmpty(userName) ||
        TextUtil.isEmpty(pwd) ||
        userName.length < 6 ||
        userName.length > 12 ||
        pwd.length < 6 ||
        pwd.length > 14) {
      ToastUtil.showCenterShort("账号或密码格式错误");
      return;
    }
    DemoUserInfoDbProvider provider = new DemoUserInfoDbProvider();
    User user = await provider.getUserInfo(userName);
    if (user != null) {
      if (user.pwd != pwd) {
        await showDialog(context: context,barrierDismissible: true,builder: (BuildContext context)=>ShowProgress(content: '密码错误',));
//        ToastUtil.showCenterShort("密码错误");
      } else {
        await showDialog(context: context,barrierDismissible: true,builder: (BuildContext context)=>ShowProgress(content: '登录成功',));
//        ToastUtil.showCenterShort("登录成功");
        await SpUtils.addBool(SpUtils.IS_LOGIN, true);
        await SpUtils.addString(SpUtils.NICK_NAME, user.nickName);
        await SpUtils.addString(SpUtils.USER_ACCOUNT, user.userName);
        Navigator.pop(context, true);
      }
    } else {
      await showDialog(context: context,barrierDismissible: true,builder: (BuildContext context)=>ShowProgress(content: '账号不存在',));
//      ToastUtil.showCenterShort("账号不存在");
    }
  }
}

Widget getRegisterLoginRow(TextEditingController controller, String hintText,
    Icon icon, bool obscureText) {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  return Padding(
    padding: EdgeInsets.fromLTRB(
        leftRightPadding, 50.0, leftRightPadding, topBottomPadding),
    child: TextField(
      keyboardType: TextInputType.number,
      style: hintTips,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
      ),
      autofocus: true,
      obscureText: obscureText, //是否隐藏正在编辑的文本
    ),
  );
}
