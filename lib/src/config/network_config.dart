import 'dart:io';

import 'package:chopper/src/base.dart';
import 'package:lz_flutter/src/network/debugger_interceptor.dart';

import '../interface/i_network_config.dart';
import '../interface/i_network_interceptor.dart';
import '../network/json_to_type_converter.dart';


class NetWorkConfig extends INetWorkConfig {
  List<INetWorkInterceptor> _netWorkInterceptor = [HttpRequestSignatureInterceptor()];
  String _domain = '';
  String _proxy = '';
  Function _httpsCertificate;
  Iterable<ChopperService> _repositories;
  bool isJsonConverterEnable = true;
  JsonToTypeConverter _jsonToTypeConverter;
  JsonToTypeConverter _errorJsonToTypeConverter;
  Duration _connectionTimeout = Duration(seconds: 60);

  @override
  INetWorkConfig addNetWorkInterceptor(List<INetWorkInterceptor> iNetWorkInterceptor) {
    _netWorkInterceptor.addAll(iNetWorkInterceptor);
    return this;
  }

  @override
  String getDomain() => _domain;

  @override
  Function getHttpsCertificate() => _httpsCertificate;

  @override
  List<INetWorkInterceptor> getNetWorkInterceptor() => _netWorkInterceptor;

  @override
  String getProxy() => _proxy;

  @override
  INetWorkConfig setApiDomain(String domain) {
    _domain = domain;
    return this;
  }

  @override
  INetWorkConfig setHttpsCertificate(
      bool Function(X509Certificate cert, String host, int port) callback) {
    _httpsCertificate = callback;
    return this;
  }

  @override
  INetWorkConfig setProxy(String proxy) {
    _proxy = proxy;
    return this;
  }

  @override
  Iterable<ChopperService> getRepository() => _repositories;

  @override
  INetWorkConfig setRepository(Iterable<ChopperService> repositories) {
    _repositories = repositories;
    return this;
  }

  @override
  JsonToTypeConverter getJsonConverter() => _jsonToTypeConverter;

  @override
  INetWorkConfig setJsonConverter(JsonToTypeConverter jsonToTypeConverter) {
    _jsonToTypeConverter = jsonToTypeConverter;
    return this;
  }

  @override
  Duration getConnectionTimeout() => _connectionTimeout;

  @override
  INetWorkConfig setConnectionTimeout(Duration duration) {
    _connectionTimeout = duration;
    return this;
  }

  @override
  JsonToTypeConverter getErrorJsonConverter() => _errorJsonToTypeConverter;

  @override
  INetWorkConfig setErrorJsonConverter(JsonToTypeConverter jsonToTypeConverter) {
    _errorJsonToTypeConverter = jsonToTypeConverter;
    return this;
  }

}
