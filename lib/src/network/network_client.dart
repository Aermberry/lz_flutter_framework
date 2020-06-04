import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart' as http;

import '../config/config.dart';

class Api {
  static ChopperClient _chopperClient;
  static Api _instance;

  static Api getInstance() {
    if (_instance == null) _instance = Api();
    return _instance;
  }

  ChopperClient getClient() {
    if (_chopperClient == null) {
      var httpClient = new HttpClient();
      if(Config.getInstance().netWorkConfig.getConnectionTimeout() != null)
        httpClient.connectionTimeout = Config.getInstance().netWorkConfig.getConnectionTimeout();
      if (Config.getInstance().netWorkConfig.getHttpsCertificate() != null)
        httpClient.badCertificateCallback =
            Config.getInstance().netWorkConfig.getHttpsCertificate();
      else
        httpClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
      if (Config.getInstance().netWorkConfig.getProxy() != null)
        httpClient.findProxy =
            (url) => Config.getInstance().netWorkConfig.getProxy();

      _chopperClient = ChopperClient(
          interceptors: [
            (request) async => requestInterceptor(request),
            (response) async => responseInterceptor(response),
          ],
          converter:
              Config.getInstance().netWorkConfig.getJsonConverter() == null
                  ? null
                  : Config.getInstance().netWorkConfig.getJsonConverter(),
          client: http.IOClient(httpClient),
          baseUrl: Config.getInstance().netWorkConfig.getDomain(),
          services: Config.getInstance().netWorkConfig.getRepository());
    }
    return _chopperClient;
  }

  Request requestInterceptor(Request request) {
    var interceptor =
        Config.getInstance().netWorkConfig.getNetWorkInterceptor();
    if (interceptor == null) return request;
    var requestBefore = interceptor.requestBefore(request);
    if (requestBefore == null) return request;
    return requestBefore;
  }

  Response responseInterceptor(Response response) {
    var interceptor =
        Config.getInstance().netWorkConfig.getNetWorkInterceptor();
    if (interceptor == null) return response;
    if (response.statusCode != 200) {
      interceptor.requestError(response.statusCode, response);
    }
    var responseAfter = interceptor.requestAfter(response);
    if (responseAfter == null) return response;
    return responseAfter;
  }
}
