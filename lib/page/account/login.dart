import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:model_mall/page_constance.dart';
import 'package:model_mall/common/utils/toast.dart';
import 'package:model_mall/common/http/http.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xFFF90850),
          leading: IconButton(
              icon: Image.asset(
                'assets/images/icon_back.png',
                width: 9,
                height: 17,
              ),
              onPressed: _back(context)),
        ),
        body: LoginWidget());
  }

  _back(BuildContext context) {
    Navigator.maybePop(context, "ha");
  }
}

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginWidget> {
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new ListView(
          children: <Widget>[
            _title(),
            _CustomTextField(phoneController),
            _PwdTextField(passController),
            _contactUs(),
            _loginButton(phoneController, passController),
          ],
        ),
        _weChatWidget()
      ],
    );
  }

  Widget _CustomTextField(TextEditingController phoneController) {
    return Container(
        padding:
            const EdgeInsets.only(left: 20, top: 39, bottom: 10, right: 20),
        child: Container(
          height: 62,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Image.asset(
                'assets/images/icon_phone.png',
                width: 16,
                height: 16,
              ),
              TextField(
                maxLength: 11,
                maxLines: 1,
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 40),
                  labelText: '请输入账号',
//            helperText: "请输入手机号"
                ),
                autofocus: false,
                onChanged: (str) {
                  setState(() {});
                },
              )
            ],
          ),
        ));
  }

  Widget _PwdTextField(TextEditingController passController) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
      child: Container(
        height: 60,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Image.asset(
              'assets/images/icon_pwd.png',
              width: 16,
              height: 16,
            ),
            TextField(
              maxLength: 6,
              maxLines: 1,
              obscureText: true,
              controller: passController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 40),
                labelText: '请输入验证码',
              ),
              autofocus: false,
              onChanged: (str) {
                setState(() {});
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: VerifyCodeBar(),
            )
          ],
        ),
      ),
    );
  }

  void login() async {
    FormData formData = new FormData.from(
        {"userName": phoneController.text, "userPass": passController.text});
    Response response = await dio.post("/user/login", data: formData);
    print(response);
    var data = response.data;
    if (data['code'] == 0) {
      _goHome();
    } else {
      Toast.toast(context, data['msg']);
    }
  }

  void _goHome() {
    phoneController.clear();
    passController.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
        PageConstance.MAIN_SCREEN_PAGE, (Route<dynamic> route) => false);
  }

  bool _canLogin(TextEditingController phoneController,
      TextEditingController passController) {
    return phoneController.text.length == 11 && passController.text.length == 6;
  }

  void _login() {
    if (_canLogin(phoneController, passController)) {
      login();
    }
  }

  Widget _loginButton(TextEditingController phoneController,
      TextEditingController passController) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 67, right: 20),
      child: InkWell(
        onTap: _login,
        child: new Container(
          alignment: Alignment.center,
          height: 44.0,
          decoration: new BoxDecoration(
            color: _canLogin(phoneController, passController)
                ? Color(0xFFF90850)
                : Color(0xFFD8D8D8),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: new Text(
            '登录',
            style: new TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

void _weChat() {
  //todo 微信登录
}

Widget _weChatWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Color(0xFFE6E6E6),
            height: 1,
            width: 110,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.center,
            child: Text("第三方账号登录",
                style: TextStyle(fontSize: 14, color: Color(0xff333333))),
          ),
          Container(
            color: Color(0xFFE6E6E6),
            height: 1,
            width: 110,
          )
        ],
      ),
      IconButton(
        padding: const EdgeInsets.all(0),
        icon: Image.asset(
          'assets/images/icon_wechat.png',
          width: 32,
          height: 32,
        ),
        onPressed: _weChat,
      ),
      Container(
        padding: const EdgeInsets.only(bottom: 15),
        child: Text("微信",
            style: TextStyle(fontSize: 10, color: Color(0xFF666666))),
      )
    ],
  );
}

Widget _title() {
  return Container(
    padding: const EdgeInsets.only(left: 20, top: 20),
    alignment: Alignment.centerLeft,
    child: Text(
      '手机号登录/注册',
      style: new TextStyle(fontSize: 24.0, color: Color(0xFF333333)),
    ),
  );
}

Widget _contactUs() {
  return Container(
    padding: const EdgeInsets.only(right: 20, top: 7),
    alignment: Alignment.centerRight,
    child: Text(
      '收不到验证码？联系客服',
      style: new TextStyle(fontSize: 12.0, color: Color(0xFF999999)),
    ),
  );
}

class VerifyCodeBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VerifyCodeBarState();
  }
}

class VerifyCodeBarState extends State<VerifyCodeBar> {
  int _seconds = 0;
  Timer _timer;
  String _verifyStr = "获取验证码";

  _startTimer() {
    _seconds = 10;
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }
      _seconds--;
      _verifyStr = '$_seconds(s)';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (_seconds == 0)
          ? () {
              setState(() {
                _startTimer();
              });
            }
          : null,
      child: new Container(
        alignment: Alignment.center,
        width: 108.0,
        height: 30.0,
        decoration: new BoxDecoration(
          color: Color(0xFFF90850),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: new Border.all(
            width: 1.0,
            color: Color(0xFFF90850),
          ),
        ),
        child: new Text(
          '$_verifyStr',
          style: new TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
    );
  }
}
