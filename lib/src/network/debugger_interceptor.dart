import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lz_flutter/src/debugger/domain/request_result.dart';
import '../../flutter_base.dart';

List<RequestResult> networkResults = [];

class HttpRequestSignatureInterceptor extends INetWorkInterceptor {

  @override
  Request requestBefore(Request request) {
    return request;
  }

  @override
  Response requestAfter(Response response) {
    final request = response.base.request as http.Request;
    final requestData = RequestData(request.headers,request.body);
    final responseData = RequestData(response.headers, jsonEncode(response.body));
    networkResults.add(    RequestResult(
        response.statusCode, request.method, request.url.path.split('/v1/').last, DateTime.now(),
        request: requestData, response: responseData));
    return response;
  }


  @override
  void requestError(Request request, Response<dynamic> response) {}

}