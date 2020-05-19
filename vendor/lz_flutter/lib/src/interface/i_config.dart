import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'i_router_config.dart';
import 'i_network_config.dart';
import 'i_network_interceptor.dart';
import 'i_resource_config.dart';

abstract class IConfig {

  IResourceConfig resourceConfig;

  INetWorkConfig netWorkConfig;

  IRouterConfig routerConfig;

  IConfig init();

}
