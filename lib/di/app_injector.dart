import 'package:inject/inject.dart';
import 'package:lz_flutter_app/config/json_converter.dart';
import 'package:lz_flutter_app/config/router.dart';
import '../main.dart';
import 'app_injector.inject.dart' as g;

@Injector()
abstract class AppInjector {

  @provide
  MyApp get myApp;

  @provide
  Routers get router;

  @provide
  JsonConverter get jsonConverter;

  static Future<AppInjector> create() {
    return g.AppInjector$Injector.create();
  }

}
