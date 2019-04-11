import 'package:flutter/material.dart';
import 'package:model_mall/page_constance.dart';

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
        new CustomTextField(phoneController),
        new PwdTextField(passController),
        RaisedButton(
          onPressed: _login,
          child: Text('登录'),
        ),
      ],
    );
  }

  void _login() {
    if (phoneController.text.length != 11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('手机号码格式不对'),
              ));
    } else if (passController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('请填写密码'),
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('登录成功'),
              ));
    }
    _goHome();
  }

  void _goHome() {
    phoneController.clear();
    passController.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
        PageConstance.HOME_PAGE, (Route<dynamic> route) => false);
  }
}

class CustomTextField extends StatelessWidget {
  TextEditingController phoneController;

  CustomTextField(this.phoneController) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, top: 150, bottom: 20, right: 30),
      child: TextField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10, bottom: 10),
          icon: Icon(Icons.perm_identity),
          labelText: '请输入账号',
//            helperText: "请输入手机号"
        ),
        autofocus: false,
      ),
    );
  }
}

class PwdTextField extends StatelessWidget {
  TextEditingController passController;

  PwdTextField(this.passController) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, top: 30, bottom: 20, right: 30),
      child: TextField(
        controller: passController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10, bottom: 10),
          icon: Icon(Icons.lock_open),
          labelText: '请输入密码',
//            helperText: "请输入手机号"
        ),
        autofocus: false,
      ),
    );
  }
}
