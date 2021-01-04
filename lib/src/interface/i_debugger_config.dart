import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';

import '../network/json_to_type_converter.dart';
import 'i_network_interceptor.dart';

abstract class IDebuggerConfig {

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void showDebuggerFloatingButton(BuildContext buildContext);

}
