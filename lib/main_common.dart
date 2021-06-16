import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/proxy.dart';
import 'package:lz_flutter_app/res/string/en.dart';
import 'package:lz_flutter_app/res/string/zh.dart';
import 'package:lz_flutter_app/security/remote_persistencce/security_retrofit.dart';

import 'config/http_request_auto_retry_interceptor.dart';
import 'config/http_request_signature_interceptor.dart';
import 'home/page/home.dart';
import 'main_common.config.dart';

late String apiDomain;
late bool isDebug;

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(getIt);

//build指令 ./flutterw pub run build_runner watch --delete-conflicting-outputs

Future<void> mainCommon(String apiServerUrl, {bool debug = false}) async {
  isDebug = debug;
  apiDomain = apiServerUrl;
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

Future<void> init() async {
  configureDependencies(); //初始化IOC
  await SpUtil.getInstance(); //初始化SharedPreferences
  if (isDebug) {
    Config.getInstance().netWorkConfig.setProxy(proxy); //如果是main_debug入口才会启用代理
  }
  Config.getInstance().debuggerConfig.startCatchAllException(); //开启全局异常捕获
  Config.getInstance().resourceConfig //资源配置
      .setLocalRes({'zh': zh, 'en': en}) //传入 国际化文件
      .setDefaultLanguageCode('zh'); //国际化文件没有当前手机语言时 显示的默认语言
  Config.getInstance()
      .netWorkConfig //网络配置
      .setApiDomain(apiDomain) //Api Domain
      .setConnectionTimeout(15 * 1000) //设置超时时间
      .addNetWorkInterceptor([
    getIt<HttpRequestSignatureInterceptor>()
  ]).setRepository([SecurityRetrofit(Api.getClient())]); //添加网络拦截器
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: Config.getInstance()
            .debuggerConfig
            .navigatorKey, //添加debugger悬浮框需要配置navigatorKey
        title: 'Flutter Demo',
        home: getIt<HomePage>(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      );
}
