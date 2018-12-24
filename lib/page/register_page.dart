import 'package:flutter/material.dart';
import 'package:flutter_48_xhdq/db/db_manager.dart';
import 'package:flutter_48_xhdq/db/user.dart';
import 'package:flutter_48_xhdq/page/login_page.dart';
import 'package:flutter_48_xhdq/util/baseutil.dart';
import 'package:flutter_48_xhdq/widget/ensure_visible_when_focused.dart';
import 'package:flutter_48_xhdq/widget/show_progrogress.dart';

class RegisterPage extends StatefulWidget {
  static void pushPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterPage()));
  }

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  var _userNameController = TextEditingController();
  var _passWordController_1 = TextEditingController();
  var _passWordController_2 = TextEditingController();
  var _nickNameCOntroller = TextEditingController();
  var _focusNodeFirstName = FocusNode();
  var _firstNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: ListView(
        children: <Widget>[
          getRegisterLoginRow(_userNameController, '6-12位数字或字母账号',
              Icon(Icons.account_box), false),
          getRegisterLoginRow(
              _passWordController_1, '6-14位数字或字母密码', Icon(Icons.lock), true),
          getRegisterLoginRow(
              _passWordController_2, '确认密码', Icon(Icons.lock), true),
          getRegisterLoginRow(
              _nickNameCOntroller, '昵称', Icon(Icons.account_circle), false),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),
              onPressed: _register,
              child: Text(
                '注册',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  bool isRegisting = false;

  void _register() async {
    if (isRegisting) {
      ToastUtil.showCenterShort("正在注册，请稍后...");
      return;
    }
    String userName = _userNameController.text.trim(); //用户名
    String pwd1 = _passWordController_1.text.trim(); //密码
    String pwd2 = _passWordController_2.text.trim(); //确认密码
    String nickName = _nickNameCOntroller.text.trim();
    if (TextUtil.isEmpty(userName) ||
        TextUtil.isEmpty(pwd1) ||
        TextUtil.isEmpty(pwd2)) {
      ToastUtil.showCenterShort('密码或账号不能为空');
      return;
    }
    if (TextUtil.isEmpty(nickName)) {
      ToastUtil.showCenterShort('请输入昵称');
      return;
    }

    if (pwd1 != pwd2) {
      ToastUtil.showCenterShort('两次密码不一致');
      return;
    }
    if (userName.length < 6 ||
        userName.length > 12 ||
        pwd2.length < 6 ||
        pwd2.length > 14) {
      ToastUtil.showCenterShort('账号或密码格式错误');
      return;
    }
    isRegisting = true;
    DemoUserInfoDbProvider provider = new DemoUserInfoDbProvider();
    User user = await provider.getUserInfo(userName);
    if (user != null) {
      await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => ShowProgress(
                content: '用户已存在',
              ));
//      ToastUtil.showCenterShort("用户已存在");
    } else {
      var res = await provider.insert(userName, pwd1, nickName);
      if (res != 0) {
        await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) => ShowProgress(
                  content: '注册成功',
                ));
//        ToastUtil.showCenterShort("注册成功");
        Navigator.pop(context);
      } else {
        await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) => ShowProgress(
                  content: '注册失败',
                ));
//        ToastUtil.showCenterShort("注册失败");
      }
    }
    isRegisting = false;
  }
}
