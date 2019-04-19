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
    return new Column(
      children: <Widget>[
        _CustomTextField(phoneController),
        _PwdTextField(passController),
        RaisedButton(
          onPressed: _login,
          child: Text('登录'),
        ),
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
}

Widget _CustomTextField(TextEditingController phoneController) {
  return Container(
    padding: const EdgeInsets.only(left: 20, top: 150, bottom: 20, right: 20),
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
  );
}

Widget _PwdTextField(TextEditingController passController) {
  return Container(
    padding: const EdgeInsets.only(left: 20, top: 5, bottom: 20, right: 20),
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
        )
      ],
    ),
  );
}
