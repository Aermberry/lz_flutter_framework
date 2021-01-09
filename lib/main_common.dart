import 'package:flutter/material.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/proxy.dart';
import 'package:lz_flutter_app/res/string/en.dart';
import 'package:lz_flutter_app/res/string/zh.dart';

import 'di/app_injector.dart';

AppInjector injector;
String apiDomain;
bool isDebug;

//build指令 ./flutterw pub run build_runner watch --delete-conflicting-outputs

Future<void> mainCommon(String apiServerUrl,{bool debug = false}) async {
  isDebug = debug;
  apiDomain = apiServerUrl;
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

Future<void> init() async {
  injector = await AppInjector.create(); //初始化Injector
  await SpUtil.getInstance(); //初始化SharedPreferences

  if(isDebug){
    Config.getInstance().netWorkConfig.setProxy(proxy); //如果是main_debug入口才会启用代理
  }

  Config.getInstance().debuggerConfig.startCatchAllException(); //开启全局异常捕获

  Config.getInstance().resourceConfig //资源配置
      .setLocalRes({'zh': zh, 'en': en}) //传入 国际化文件
      .setDefaultLanguageCode('zh'); //国际化文件没有当前手机语言时 显示的默认语言

  Config.getInstance()
      .netWorkConfig //网络配置
      .setApiDomain(apiDomain) //Api Domain
      .setConnectionTimeout(const Duration(seconds: 15)) //设置超时时间
      .setJsonConverter(//Json自动序列化
          JsonToTypeConverter(injector.jsonConverter.getJsonConvert()))
      .addNetWorkInterceptor([
    injector.httpRequestAutoRetryInterceptor,
    injector.httpRequestSignatureInterceptor
  ]); //添加opper的拦截器
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    navigatorKey: Config.getInstance().debuggerConfig.navigatorKey, //添加debugger悬浮框需要配置navigatorKey
      title: 'Flutter Demo',
       routes: injector.router.getRoutersData(injector),
       initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
}
