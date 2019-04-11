import 'package:flutter/material.dart';
import 'package:model_mall/page/splash.dart';
import 'package:model_mall/page_constance.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mall',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: WelcomePage(),
      routes: PageConstance.getRoutes(),
    );
  }
}
