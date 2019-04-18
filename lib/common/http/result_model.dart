import 'package:model_mall/common/http/result_code.dart';

class ResultModel {
  int code;
  String msg;
  var data;

  bool get success => code == ResultCode.SUCCESS;

  // ignore: avoid_init_to_null
  ResultModel(this.code, this.msg, {this.data: null});
}
