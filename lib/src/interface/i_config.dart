import 'dart:io';

import 'i_network_config.dart';
import 'i_network_interceptor.dart';
import 'i_resource_config.dart';

abstract class IConfig {

  IResourceConfig resourceConfig;

  INetWorkConfig netWorkConfig;

  IConfig init();

}
