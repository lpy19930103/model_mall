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
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
        body: LoginWidget());
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
    return new ListView(
      children: <Widget>[
        _CustomTextField(phoneController),
        _PwdTextField(passController),
        _loginButton(),
      ],
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

  void _login() {
    if (phoneController.text.length != 11) {
      Toast.toast(context, "请输入正确的手机号");
    } else if (passController.text.length == 0) {
      Toast.toast(context, "请填写密码");
    } else {
      login();
    }
  }

  void _goHome() {
    phoneController.clear();
    passController.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
        PageConstance.MAIN_SCREEN_PAGE, (Route<dynamic> route) => false);
  }

  Widget _loginButton() {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 67, right: 20),
      child: InkWell(
        onTap: _login,
        child: new Container(
          alignment: Alignment.center,
          height: 44.0,
          decoration: new BoxDecoration(
            color: Color(0xFFF90850),
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

Widget _CustomTextField(TextEditingController phoneController) {
  return Container(
      padding: const EdgeInsets.only(left: 20, top: 150, bottom: 10, right: 20),
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
                contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 40),
                labelText: '请输入账号',
//            helperText: "请输入手机号"
              ),
              autofocus: false,
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
