import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/proxy.dart';
import 'package:lz_flutter_app/res/string/en.dart';
import 'package:lz_flutter_app/res/string/zh.dart';

import 'config/router.dart';
import 'config/signature_interceptor.dart';
import 'di/app_injector.dart';

AppInjector injector;
String apiDomain;

void mainCommon(String apiServerUrl) async {
  apiDomain = apiServerUrl;
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(injector.home);
}

Future<void> init() async {
  Config.getInstance().init(); //框架 初始化
  injector = await AppInjector.create(); //初始化Injector
  await SpUtil.getInstance(); //初始化SharedPreferences

  Config.getInstance().resourceConfig //资源配置
      .setLocalRes({"zh": zh, "en": en}) //传入 国际化文件
      .setDefaultLanguageCode("zh"); //国际化文件没有当前手机语言时 显示的默认语言

  Config.getInstance()
      .netWorkConfig //网络配置
      .setApiDomain(apiDomain) //Api Domain
      .setProxy(PROXY)
      .setConnectionTimeout(Duration(seconds: 15)) //设置超时时间
      .setJsonConverter(//Json自动序列化
          JsonToTypeConverter(injector.jsonConverter.getJsonConvert()))
      .addNetWorkInterceptor(SignatureInterceptor()); //添加Chopper的拦截器
}

@provide
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: injector.router.getRoutersData(),
      initialRoute: "/",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      )
    );
  }
}
