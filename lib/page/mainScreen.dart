import 'package:flutter/material.dart';
import 'home.dart';
import 'order.dart';
import 'mine.dart';
import 'package:model_mall/view/bottom_bar/bottom_tab_bar.dart';

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

  @override
  void initState() {
    badgeNo1 = '11';
    super.initState();
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
        fixedColor: Colors.red,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomTabBarType.fixed,
        isAnimation: false,
        isInkResponse: false,
        badgeColor: Colors.red,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
