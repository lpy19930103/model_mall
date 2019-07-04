import 'package:flutter/material.dart';
import 'package:model_mall/common/utils/toast.dart';
import 'package:model_mall/page_constance.dart';
import 'package:transparent_image/transparent_image.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[_UserInfoWidget(), _MineWidget(), _MineMenu()],
      ),
    );
  }
}

class _UserInfoWidget extends StatefulWidget {
  @override
  _UserInfoWidgetState createState() => new _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<_UserInfoWidget> {
  var userName = "登录/注册";
  var loginType = "您暂时还未登录";

  _login() {
    if (userName == "登录/注册") {
      Navigator.of(context).pushNamed(PageConstance.LOGIN_PAGE).then((data) {
        Toast.toast(context, data);
        setState(() {
          userName = data;
          loginType = "";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: GestureDetector(
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Container(
            height: 100,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            alignment: Alignment.centerLeft,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: new Row(
                    children: <Widget>[
                      FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          width: 60,
                          height: 60,
                          image:
                              "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1557299852&di=d91ff2dc819dc9c6ff87621e42fb72bf&src=http://ku.90sjimg.com/element_origin_min_pic/01/37/41/87573c4bdacf52b.jpg",
                          fit: BoxFit.cover),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        userName,
                        style: TextStyle(fontSize: 14, color: Colors.black38),
                      ),
                      Text(
                        loginType,
                        style: TextStyle(fontSize: 14, color: Colors.black38),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: _login,
      ),
    );
  }
}

class _MineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(14),
      color: Colors.white,
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Icon(Icons.ac_unit),
                Text("ICON"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Icon(Icons.ac_unit),
                Text("ICON"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Icon(Icons.ac_unit),
                Text("ICON"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Icon(Icons.ac_unit),
                Text("ICON"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MineMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      color: Colors.white,
      elevation: 1,
      child: new Column(
        children: [
          new Container(
            color: Colors.white70,
            height: 45.0,
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.ac_unit),
                    Text("功能1"),
                  ],
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          new Container(
            color: Colors.white70,
            height: 45.0,
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.ac_unit),
                    Text("功能2"),
                  ],
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          new Container(
            color: Colors.white70,
            height: 45.0,
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.ac_unit),
                    Text("功能3"),
                  ],
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          new Container(
            color: Colors.white70,
            height: 45.0,
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.ac_unit),
                    Text("功能4"),
                  ],
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          new Container(
            color: Colors.white70,
            height: 45.0,
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.ac_unit),
                    Text("功能5"),
                  ],
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          new Container(
            color: Colors.white70,
            height: 45.0,
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.ac_unit),
                    Text("功能6"),
                  ],
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
