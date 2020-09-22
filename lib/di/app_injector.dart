import 'package:inject/inject.dart';
import 'package:lz_flutter_app/config/http_request_auto_retry_interceptor.dart';
import 'package:lz_flutter_app/config/http_request_signature_interceptor.dart';
import 'package:lz_flutter_app/config/json_converter.dart';
import 'package:lz_flutter_app/config/router.dart';
import 'package:lz_flutter_app/home/page/home.dart';
import 'app_injector.inject.dart' as g;

@Injector()
abstract class AppInjector {
  @provide
  HomePage get home;

  @provide
  Routers get router;

  @provide
  JsonConverter get jsonConverter;

  @provide
  HttpRequestAutoRetryInterceptor get httpRequestAutoRetryInterceptor;

  @provide
  HttpRequestSignatureInterceptor get httpRequestSignatureInterceptor;

  static Future<AppInjector> create() => g.AppInjector$Injector.create();
}
