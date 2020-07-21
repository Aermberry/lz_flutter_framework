import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';
import 'package:lz_flutter_app/di/app_injector.dart';

@provide
class Routers {
  Map<String, WidgetBuilder> getRoutersData(AppInjector appInjector) =>
      {"/": (BuildContext context) => appInjector.home
      };
}
