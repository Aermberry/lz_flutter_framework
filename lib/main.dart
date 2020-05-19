import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/res/string/en.dart';
import 'package:lz_flutter_app/res/string/zh.dart';

import 'config/signature_interceptor.dart';
import 'di/app_injector.dart';

AppInjector injector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(injector.myApp);
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
      .setApiDomain("https://") //Api Domain
      .setConnectionTimeout(Duration(seconds: 15)) //设置超时时间
      .setJsonConverter(//Json自动序列化
          JsonToTypeConverter(injector.jsonConverter.getJsonConvert()))
//      .setRepository([SecurityRepository.create()])     //传入Chopper的Repository
      .addNetWorkInterceptor(SignatureInterceptor()); //添加Chopper的拦截器

  Config.getInstance()
      .routerConfig //路由配置
      .addRouterProvider(injector.router.getRoutersData()); //传入路由配置
}

@provide
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute:
          RouterManager.getInstance().getRouter().generator, //fluro 路由配置
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
