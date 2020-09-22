import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/network/biz/http_request_auto_retry_biz.dart';
import 'package:lz_flutter_app/network/domains/simple_http_request.dart';



@provide
class HttpRequestAutoRetryInterceptor extends INetWorkInterceptor{

  HttpRequestAutoRetryBiz _retryNetworkBiz;

  HttpRequestAutoRetryInterceptor(this._retryNetworkBiz);

  @override
  Request requestBefore(Request request) {
    return request;
  }

  @override
  Response requestAfter(Response response) {
    return response;
  }


  @override
  void requestError(Request request, Response<dynamic> response) {
    SimpleHttpRequest record;
    if(request!=null){   ///没网路的情况下 request不为null
      record =  SimpleHttpRequest(method: request.method,url: request.url,body:  request.body is String ?  request.body : jsonEncode(request.body));
    }else{  ///服务器返回错误
      if(response.statusCode < 500)
        return;

      record =  SimpleHttpRequest(method: request.method,url: request.url,body:  jsonEncode((response.base.request as Request).body));
    }
    _retryNetworkBiz.saveNetworkRecord(record);
  }



}