import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart' as httpIo;
import 'package:http/http.dart' as http;

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
      if (Config.getInstance().netWorkConfig.getConnectionTimeout() != null)
        httpClient.connectionTimeout =
            Config.getInstance().netWorkConfig.getConnectionTimeout();
      if (Config.getInstance().netWorkConfig.getHttpsCertificate() != null)
        httpClient.badCertificateCallback =
            Config.getInstance().netWorkConfig.getHttpsCertificate();
      else
        httpClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
      if (Config.getInstance().netWorkConfig.getProxy() != null)
        httpClient.findProxy =
            (url) => Config.getInstance().netWorkConfig.getProxy();

      _chopperClient = MyChopperClient(
          interceptors: [
            (request) async => requestInterceptor(request),
            (response) async => responseInterceptor(response),
          ],
          converter:
              Config.getInstance().netWorkConfig.getJsonConverter() == null
                  ? null
                  : Config.getInstance().netWorkConfig.getJsonConverter(),
          client: httpIo.IOClient(httpClient),
          baseUrl: Config.getInstance().netWorkConfig.getDomain(),
          services: Config.getInstance().netWorkConfig.getRepository());
    }
    return _chopperClient;
  }

  Request requestInterceptor(Request request) {
    Request requestBefore = request;
    Config.getInstance()
        .netWorkConfig
        .getNetWorkInterceptor()
        .forEach((interceptor) {
      requestBefore = interceptor.requestBefore(requestBefore);
    });
    return requestBefore;
  }

  Response responseInterceptor(Response response) {
    Response responseAfter = response;
    Config.getInstance()
        .netWorkConfig
        .getNetWorkInterceptor()
        .forEach((interceptor) {
      if (response.statusCode != 200 || response.statusCode != 201) {
        interceptor.requestError(null, response);
      }
      responseAfter = interceptor.requestAfter(responseAfter);
    });
    return responseAfter;
  }
}

class MyChopperClient extends ChopperClient {
  MyChopperClient({
    baseUrl: "",
    http.Client client,
    Iterable interceptors,
    Converter converter,
    ErrorConverter errorConverter,
    Iterable<ChopperService> services,
  }) : super(
            baseUrl: baseUrl,
            client: client,
            interceptors: interceptors,
            converter: converter,
            errorConverter: errorConverter,
            services: services);

  @override
  Future<Response<BodyType>> send<BodyType, InnerType>(Request request,
      {requestConverter, responseConverter}) async {
    Response<BodyType> response;

    return super
        .send(request,
            requestConverter: requestConverter,
            responseConverter: responseConverter)
        .catchError((e) {
      print(e);
      var interceptor = Config.getInstance()
          .netWorkConfig
          .getNetWorkInterceptor()
          .forEach((interceptor) {
        interceptor.requestError(request, null);
      });
    });
  }
}
