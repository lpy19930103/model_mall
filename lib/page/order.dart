import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "Order",
          textScaleFactor: 5,
        ),
      ),
    );
  }
}
