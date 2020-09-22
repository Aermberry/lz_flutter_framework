import 'dart:convert';


import 'package:inject/inject.dart';
import 'package:lz_flutter/flutter_base.dart';



@provide
class HttpRequestSignatureInterceptor extends INetWorkInterceptor{

  @override
  Request requestBefore(Request request) {
    request.headers['X-OPENINVITE-SIGNATURE'] = "";
    request.headers['X-OPENINVITE-TIMESTAMP'] = "";
    request.headers['X-OPENINVITE-NONCE'] = "";
    request.headers['X-OPENINVITE-DEVICE-ID'] = "";
    return request;
  }

  @override
  Response requestAfter(Response response) {
    return response;
  }


  @override
  void requestError(Request request, Response<dynamic> response) {

  }



}