import 'package:lz_flutter/flutter_base.dart';

class SignatureInterceptor extends INetWorkInterceptor {
  @override
  Request requestBefore(Request request) => request;

  @override
  Response requestAfter(Response response) => response;

  @override
  void requestError(int code, Response response) {
    print('requestError ' + code.toString());
  }
}
