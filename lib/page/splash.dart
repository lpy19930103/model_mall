import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:model_mall/page_constance.dart';
import 'package:model_mall/skip_down_time.dart';


class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage>
    implements OnSkipClickListener {
  var welcomeImageUrl =
      "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1554884211&di=b15ac210e552463171884249381b6271&src=http://b-ssl.duitang.com/uploads/item/201504/03/20150403H1232_RJ2iV.jpeg";

  @override
  void initState() {
    super.initState();
    _getWelcomeImage();
    _delayedGoHomePage();
  }

  _getWelcomeImage() async {
    /*  String url = AppConstance.makeUrl('services/app_ad_cover.json', null);
    var response = await http.get(url);
    print(response.body);
    List list = json.decode(response.body);
    String cover = '';
    var item;
    for (item in list) {
      cover = item['field_app_ad_cover'];
      if (cover != null && cover.isNotEmpty) {
        cover = StringUtil.getSrcImagePath(cover);
        break;
      }
    }

    print('cover===$cover');
    setState(() {
      welcomeImageUrl = cover;
    });*/
  }

  _delayedGoHomePage() {
    Future.delayed(new Duration(seconds: 5), () {
      _goHomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Container(
          color: Colors.white,
          child: new Image.network(
            welcomeImageUrl,
            fit: BoxFit.cover,
          ),
          constraints: new BoxConstraints.expand(),
        ),
        new Container(
          child: Align(
            alignment: Alignment.topRight,
            child: new Container(
              padding: const EdgeInsets.only(top: 30, right: 20.0),
              child: new SkipDownTimeProgress(
                Colors.red,
                22,
                new Duration(seconds: 5),
                new Size(25, 25),
                skipText: "跳过",
                clickListener: this,
              ),
            ),
          ),
        )
      ],
    );
  }

//跳转方法
  _goHomePage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        PageConstance.LOGIN_PAGE, (Route<dynamic> route) => false);
  }

  @override
  void onSkipClick() {
    _goHomePage();
  }
}
