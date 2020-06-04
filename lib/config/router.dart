import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/main_common.dart';

@provide
class Routers {
  @provide
  MyApp _app;

  Routers(this._app);

  Map<String, dynamic> getRoutersData() =>
      {"/": (BuildContext context) => _app};

}
