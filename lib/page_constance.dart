import 'package:model_mall/page/login.dart';
import 'package:flutter/material.dart';

class PageConstance {
  static String WELCOME_PAGE = '/';
  static String LOGIN_PAGE = '/login';

  static Map<String, WidgetBuilder> getRoutes() {
    var route = {
      LOGIN_PAGE: (BuildContext context) {
        return LoginPage();
      }
    };

    return route;
  }
}
