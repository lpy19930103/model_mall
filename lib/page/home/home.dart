import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:model_mall/common/app_constance.dart';
import 'package:model_mall/common/http.dart';
import 'package:model_mall/common/toast.dart';
import 'package:model_mall/view/banner.dart';
import 'dart:math';
import 'package:model_mall/event/event.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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

  @override
  void initState() {
    super.initState();
    _getBanner();
  }

  void _getBanner() async {
    Response response =
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
    }
  }

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
            actions: <Widget>[],
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
          SliverFixedExtentList(
            delegate: SliverChildListDelegate(bannerList.map((item) {
              return _buildItem(item);
            }).toList()),
            itemExtent: 120,
          )
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
