import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/home/page/home.dart';
import 'package:lz_flutter_app/main_common.dart';

@provide
class Routers {
  @provide
  HomePage _homePage;

  Routers(this._homePage);

  Map<String, WidgetBuilder> getRoutersData() =>
      {"/": (BuildContext context) => _homePage};

}
