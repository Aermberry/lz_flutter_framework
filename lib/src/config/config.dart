import 'dart:io';

import 'package:chopper/src/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lz_flutter/src/config/debugger_config.dart';

import '../interface/i_config.dart';
import 'network_config.dart';
import 'resource_config.dart';

/**
 * 因为build runner功能有限 无法为插件内部生成代码 因此该框架使用单例的模式 而不是IOC模式
 */

class Config extends IConfig {
  static IConfig _instance;

  Config();

  static IConfig getInstance() {
    if (_instance == null) _instance = Config();
    return _instance;
  }

  @override
  IConfig init() {
    netWorkConfig = NetWorkConfig();
    resourceConfig = ResourceConfig();
    debuggerConfig = DebuggerConfig();

    return this;
  }

}
