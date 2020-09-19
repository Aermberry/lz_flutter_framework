import 'package:chopper/chopper.dart';

abstract class INetWorkInterceptor{

  Request requestBefore(Request request);

  Response requestAfter(Response response);

  void requestError(Request request,Response response);

}