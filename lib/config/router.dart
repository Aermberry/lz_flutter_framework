import 'package:inject/inject.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/main.dart';

@provide
class Routers{

  @provide
  MyApp _app;

  Routers(this._app);

  Map<String,Handler> getRoutersData() => {
    "/": Handler(
      handlerFunc: (context, parms) {
        return _app;
      },
    )};

}