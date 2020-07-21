import 'package:lz_flutter/flutter_base.dart';

class SignatureInterceptor extends INetWorkInterceptor{

  @override
  Request requestBefore(Request request) {
    return request;
  }

  @override
  Response requestAfter(Response response) {
    return response;
  }

  @override
  void requestError(int errorCode, Response response) {
    print("requestError "+ errorCode.toString());
  }

}