import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import 'i_network_interceptor.dart';
import 'i_router_provider.dart';

abstract class IRouterConfig {

  IRouterConfig addRouteDefine(String routePath, Handler handler);

  IRouterConfig addRouterProvider(Map<String,Handler> provider);

}
