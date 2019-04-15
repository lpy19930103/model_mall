import 'package:flutter/material.dart';
import 'home.dart';
import 'order.dart';
import 'mine.dart';

class MainScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreenPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  List _bodys = [HomePage(), OrderPage(), MinePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodys[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(icon: Icon(Icons.reorder), title: Text('订单')),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity), title: Text('我')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
