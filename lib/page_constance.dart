import 'package:model_mall/page/login.dart';
import 'package:model_mall/page/home.dart';
import 'package:model_mall/page/mainScreen.dart';
import 'package:flutter/material.dart';

class PageConstance {
  static String WELCOME_PAGE = '/';
  static String LOGIN_PAGE = '/login';
  static String HOME_PAGE = '/home';
  static String MAIN_SCREEN_PAGE = '/MAIN';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      LOGIN_PAGE: (context) => new LoginPage(),
      HOME_PAGE: (context) => new HomePage(),
      MAIN_SCREEN_PAGE: (context) => new MainScreenPage()
    };
  }
}
