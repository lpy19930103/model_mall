import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF90850),
      ),
      body: Container(
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
                          "登录/注册",
                          style: TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                        Text(
                          "您暂时还未登录",
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
      ),
    );
  }

  _login() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        PageConstance.MAIN_SCREEN_PAGE, (Route<dynamic> route) => false);
  }
}

class _MineWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return null;
  }
}
