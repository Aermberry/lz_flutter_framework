import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';

import '../network/json_to_type_converter.dart';
import 'i_network_interceptor.dart';

abstract class INetWorkConfig {

  /**
   * 设置代理 如 'PROXY 192.168.31.136:8888'
   */
  INetWorkConfig setProxy(String proxy);

  /**
   * 设置https证书信任，默认信任全部
   */
  INetWorkConfig setHttpsCertificate(
      bool callback(X509Certificate cert, String host, int port));

  /**
   * 设置Domain地址
   */
  INetWorkConfig setApiDomain(String domain);

  /**
   * 设置Chopper Service
   */
  INetWorkConfig setRepository(Iterable<ChopperService> service);

  /**
   * 添加网络拦截
   */
  INetWorkConfig addNetWorkInterceptor(INetWorkInterceptor iNetWorkInterceptor);

  String getProxy();

  Function getHttpsCertificate();

  String getDomain();

  Iterable<ChopperService> getRepository();

  INetWorkInterceptor getNetWorkInterceptor();

  INetWorkConfig setJsonConverter(JsonToTypeConverter jsonToTypeConverter);

  JsonToTypeConverter getJsonConverter();

  INetWorkConfig setConnectionTimeout(Duration duration);

  Duration getConnectionTimeout();

}
