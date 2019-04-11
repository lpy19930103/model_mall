import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model_mall/page/splash.dart';
import 'package:model_mall/page_constance.dart';
import 'package:model_mall/common/http.dart';
import 'package:model_mall/common/app_constance.dart';

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void main() {
// add interceptors
  dio.interceptors..add(CookieManager(CookieJar()))..add(LogInterceptor());
  (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  dio.options.receiveTimeout = 15000;
  dio.options.connectTimeout = 15000;
  dio.options.baseUrl = AppConstance.APP_HOST_URL;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
