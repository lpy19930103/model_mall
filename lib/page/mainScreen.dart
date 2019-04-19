import 'dart:async';

import 'package:flutter/material.dart';
import 'package:model_mall/page/home/home.dart';
import 'package:model_mall/page/order/order.dart';
import 'package:model_mall/page/mine/mine.dart';
import 'package:model_mall/view/bottom_bar/bottom_tab_bar.dart';
import 'package:model_mall/event/event.dart';

class MainScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreenPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  String badgeNo1;
  List _bodys = [HomePage(), OrderPage(), MinePage()];
  var _titles = ['首页', '订单', '我'];
  var _icons = [Icons.home, Icons.reorder, Icons.perm_identity];
  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = eventBus.on().listen((event) {
      setState(() {
        badgeNo1 = event.count.toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (subscription != null) {
      subscription.cancel();
      subscription = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodys[_selectedIndex],
      bottomNavigationBar: BottomTabBar(
        items: <BottomTabBarItem>[
          BottomTabBarItem(
              icon: Icon(_icons[0]),
              title: Text(_titles[0]),
              badgeNo: badgeNo1),
          BottomTabBarItem(icon: Icon(_icons[1]), title: Text(_titles[1])),
          BottomTabBarItem(icon: Icon(_icons[2]), title: Text(_titles[2])),
        ],
        fixedColor: Color(0xFFF90850),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomTabBarType.fixed,
        isAnimation: false,
        isInkResponse: false,
        badgeColor: Color(0xFFF90850),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
