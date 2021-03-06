import 'dart:async';
import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model_mall/page/splash.dart';
import 'package:model_mall/page_constance.dart';
import 'package:model_mall/common/http/http.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:model_mall/common/app_constance.dart';

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void _reportErrorAndLog(Object obj, StackTrace stack) {
  print("Error : " + obj.toString());
}

_initDio() {
  dio.interceptors..add(CookieManager(CookieJar()));
//    ..add(LogInterceptor());
  (dio.transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;
  dio.options.receiveTimeout = 15000;
  dio.options.connectTimeout = 15000;
  //  dio.options.baseUrl = AppConstance.APP_HOST_URL;
}

_initFluwx() async {
  await fluwx.register(
      appId: "wxd930ea5d5a258f4f",
      doOnAndroid: true,
      doOnIOS: true,
      enableMTA: false);
  var result = await fluwx.isWeChatInstalled();
  print("initFluwx is installed $result");
}

void main() {
  _initDio();
  _initFluwx();
  runZoned(
    () => runApp(MyApp()),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        parent.print(zone, "print: $line");
      },
    ),
    onError: (Object obj, StackTrace stack) {
      _reportErrorAndLog(obj, stack);
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //去除debug角标
      title: 'Mall',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: WelcomePage(),
      routes: PageConstance.getRoutes(),
    );
  }
}
