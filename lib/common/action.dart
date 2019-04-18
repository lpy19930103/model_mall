import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'http.dart';
import 'package:dio/dio.dart';
import 'package:model_mall/common/http/result_code.dart';
import 'package:model_mall/common/http/result_model.dart';
import 'config.dart';

class Action {
  static String baseUrl = '';
  static Map<String, String> baseHeader = {};
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

// Must be top-level function
  static _parseAndDecode(String response) {
    return jsonDecode(response);
  }

  static _parseJson(String text) {
    return compute(_parseAndDecode, text);
  }

  static init() {}

  static post(url, params) async {
    dio.options.method = "POST";
    return await requestBase(url, params, baseHeader, method: "POST");
  }

  static get(url, params) async {
    return await requestBase(url, params, baseHeader, method: "GET");
  }

  static requestBase(url, params, Map<String, String> header,
      {method: "POST"}) async {
    ///判断网络连接
/*    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
    } else if (connectivityResult == ConnectivityResult.wifi) {
    } else if (connectivityResult == ConnectivityResult.none) {
      return ResultModel(ResultCode.NETWORK_ERROR, "请检查网络");
    }*/

    ///处理请求头
    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }
    dio.options.headers = headers;
    dio.options.method = method;

    Response response;
    try {
      if (method == "GET") {
        response = await dio.request(url, queryParameters: params);
      } else {
        response = await dio.request(url, data: params);
      }
    } on DioError catch (error) {
      /// 请求错误处理
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = new Response(statusCode: ResultCode.SERVER_ERROR);
      }

      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = ResultCode.NETWORK_TIMEOUT;
      }

      if (CONFIG.DEBUG) {
        print('请求异常: ' + error.toString());
        print('请求异常url: ' + url);
      }
      return ResultModel(errorResponse.statusCode, error.message);
    }

    if (CONFIG.DEBUG) {
      print('url: ' + url);
      print('header: ' + dio.options.headers.toString());
      if (params != null) {
        print('param: ' + params.toString());
      }
      if (response != null) {
        print('response: ' + response.toString());
      }
    }

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = response.data;
        if (json == null) {
          return ResultModel(ResultCode.RESPONSE_EMPTY, "服务器响应未空");
        } else {
          return ResultModel(json['code'], json['message'], data: json['data']);
        }
      }
    } catch (error) {
      print(error.toString() + url);
      return ResultModel(ResultCode.RESPONSE_EMPTY, "未知错误:" + error.toString());
    }
  }
}
