import 'package:inject/inject.dart';
import 'package:lz_flutter_app/config/json_converter.dart';
import 'package:lz_flutter_app/config/router.dart';
import 'package:lz_flutter_app/home/pages/demo_page.dart';
import '../main_common.dart';
import 'app_injector.inject.dart' as g;

@Injector()
abstract class AppInjector {
  @provide
  MyApp get myApp;

  @provide
  Routers get router;

  @provide
  JsonConverter get jsonConverter;

  @provide
  DemoPage get demoPage;

  static Future<AppInjector> create() => g.AppInjector$Injector.create();
}
