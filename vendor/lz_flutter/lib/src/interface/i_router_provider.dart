import 'package:fluro/fluro.dart';

abstract class IRouterProvider{

  Map<String,Handler> getRouters();

}