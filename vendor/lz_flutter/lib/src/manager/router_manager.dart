import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class RouterManager {
  static RouterManager _instance;
  static Router _router;

  static RouterManager getInstance() {
    if (_instance == null) {
      _instance = RouterManager();
      _router = Router();
      _router.notFoundHandler = Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        print("路由为空,请确认是否已经配置");
        return;
      });
    }
    return _instance;
  }

  Router getRouter() => _router;

  RouterManager addRouteDefine(String routePath, Handler handler) {
    _router.define(routePath, handler: handler);
    return this;
  }

  RouterManager addRouterProvider(Map<String, Handler> provider) {
    provider.forEach((key, value) {
      addRouteDefine(key, value);
    });
    return this;
  }

  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配
  Future navigateTo(BuildContext context, String path,
      {Map<String, dynamic> params,
      bool replace = false,
      bool clearStack = false,
      TransitionType transition = TransitionType.native,
      Function(Object) resultFunction}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    print('$query');
    path = path + query;
    return _router
        .navigateTo(context, path,
            transition: transition, replace: false, clearStack: clearStack)
        .then((result) {
      if (result == null) {
        return;
      }
      resultFunction(result);
    });
  }
}
