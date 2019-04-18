import 'package:model_mall/common/http/result_code.dart';

class ResultModel<T> {
  int code;
  String msg;
  T data;

  bool get success => code == ResultCode.SUCCESS;

  // ignore: avoid_init_to_null
  ResultModel(this.code, this.msg, {this.data: null});

  @override
  String toString() {
    return 'ResultModel{code: $code, msg: $msg, data: $data}';
  }


}
