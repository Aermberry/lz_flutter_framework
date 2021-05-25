import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lz_flutter/src/debugger/domain/request_result.dart';
import '../../flutter_base.dart';

List<RequestResult> networkResults = [];

class HttpRequestSignatureInterceptor extends INetWorkInterceptor {

  @override
  Future<Request> requestBefore(Request request) async {
    return request;
  }

  @override
  Response requestAfter(Response response) {
    if(response.base.request is http.Request){
      final request = response.base.request as http.Request;
      final requestData = RequestData(request.headers,request.body);
      final responseData = RequestData(response.headers, jsonEncode(response.body));
      networkResults.add(    RequestResult(
          response.statusCode, request.method, request.url.path.split('/v1/').last, DateTime.now(),
          request: requestData, response: responseData));
    }
    return response;
  }


  @override
  void requestError(Request request, Response<dynamic> response) {}

}