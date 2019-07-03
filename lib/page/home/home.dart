import 'package:flutter/material.dart';
import 'package:model_mall/common/app_constance.dart';
import 'package:model_mall/common/http/result_model.dart';
import 'package:model_mall/common/utils/toast.dart';
import 'package:model_mall/view/banner.dart';
import 'dart:math';
import 'package:model_mall/event/event.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:model_mall/common/http/action.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  List<BannerItem> bannerList = [];
  List _data = [];

  @override
  void initState() {
    super.initState();
    _data.add(
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561816749452&di=eed1bb1465a127858016d48426faebf9&imgtype=0&src=http%3A%2F%2Fpic.97uimg.com%2Fback_pic%2F20%2F16%2F03%2F12%2F7c2d4fec0b9390a6c632259c45063cb3.jpg%2521w1200");
    _data.add(
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561816810805&di=254e0ffb4f083e13ed3d5b480d07b453&imgtype=0&src=http%3A%2F%2Fpic.97uimg.com%2Fback_pic%2F00%2F00%2F69%2F40%2F09573946046c3072c5900befb41ac723.jpg");
    _data.add(
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561816749452&di=eed1bb1465a127858016d48426faebf9&imgtype=0&src=http%3A%2F%2Fpic.97uimg.com%2Fback_pic%2F20%2F16%2F03%2F12%2F7c2d4fec0b9390a6c632259c45063cb3.jpg%2521w1200");
    _data.add(
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561816749452&di=eed1bb1465a127858016d48426faebf9&imgtype=0&src=http%3A%2F%2Fpic.97uimg.com%2Fback_pic%2F20%2F16%2F03%2F12%2F7c2d4fec0b9390a6c632259c45063cb3.jpg%2521w1200");
    _data.add(
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561816749452&di=eed1bb1465a127858016d48426faebf9&imgtype=0&src=http%3A%2F%2Fpic.97uimg.com%2Fback_pic%2F20%2F16%2F03%2F12%2F7c2d4fec0b9390a6c632259c45063cb3.jpg%2521w1200");

    _getBanner();
  }

  void _getBanner() async {
/*    Response response =
    await dio.get(Urls.BANNER, queryParameters: {"type": 0});
    print("response = " + response.toString());
    var res = response.data;
    print("res = " + res);
    if (res['code'] == 200) {
      List data = res['data'];
      data.forEach((banner) {
        BannerItem item = BannerItem.defaultBannerItem(
            banner['bannerImage'], banner['title']);
        bannerList.add(item);
      });
      setState(() {});
    } else {
      Toast.toast(context, res['message']);
    }*/

/*    ResultModel resultModel = await Action.get(Urls.BANNER, {"type": 0});
    if (resultModel.success) {
      List data = resultModel.data;*/
    bannerList.clear();
    for (int i = 0; i < _data.length; i++) {
      BannerItem item =
          BannerItem.defaultBannerItem(_data[i], "index = " + i.toString());
      bannerList.add(item);
    }
    setState(() {});
    /*   } else {
      Toast.toast(context, resultModel.msg);
    }*/
  }

  _setting() {}

  Widget _buildItem(BannerItem item) {
    return item.itemText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new EasyRefresh(
      key: _easyRefreshKey,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: _setting,
              ),
            ],
            title: Text("Home"),
//              backgroundColor: Theme.of(context).primaryColor,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: BannerWidget(
                200,
                bannerList,
                bannerPress: (pos, item) {
                  print('第 $pos 点击了');
                  BottomCountEvent event =
                      new BottomCountEvent(Random().nextInt(100));
                  eventBus.fire(event);
                },
              ),
            ),
            pinned: true, //固定导航栏
          ),
//          SliverFixedExtentList(
//            delegate: SliverChildListDelegate(bannerList.map((item) {
//              return _buildItem(item);
//            }).toList()),
//            itemExtent: 120,
//          ),
          _SliverGrid(_data)
        ],
      ),
      onRefresh: () async {
        _getBanner();
      },
//      loadMore: () {},
    ));
  }
}

///tab
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ["a", "b", "c"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      print("tab index : ${_tabController.index}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        centerTitle: true,
        bottom: TabBar(
            //生成Tab菜单
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          //创建3个Tab页
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5),
          );
        }).toList(),
      ),
    );
  }
}

class _SliverGrid extends StatelessWidget {
  var posts = [];

  _SliverGrid(this.posts);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(10.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Material(
                borderRadius: BorderRadius.circular(5),
                elevation: 14.0,
                shadowColor: Colors.grey.withOpacity(1),
                child: Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        posts[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ));
          },
          childCount: posts.length,
        ),
      ),
    );
  }
}
