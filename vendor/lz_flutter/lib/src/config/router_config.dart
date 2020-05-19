import 'package:fluro/src/common.dart';

import '../interface/i_router_config.dart';
import '../manager/router_manager.dart';


class RouterConfig extends IRouterConfig{

  @override
  IRouterConfig addRouteDefine(String routePath, Handler handler) {
    RouterManager.getInstance().addRouteDefine(routePath,handler);
    return this;
  }

  @override
  IRouterConfig addRouterProvider(Map<String, Handler> provider) {
    RouterManager.getInstance().addRouterProvider(provider);
    return this;
  }



}