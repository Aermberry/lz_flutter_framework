import 'dart:async';
import 'dart:convert';


import 'package:inject/inject.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/config/database/app_database.dart';
import 'package:lz_flutter_app/network/domains/simple_http_request.dart';

@provide
class HttpRequestAutoRetryBiz {

  AppDataBase _appDataBase;
  Timer _timer;

  HttpRequestAutoRetryBiz(this._appDataBase);

  void saveNetworkRecord(SimpleHttpRequest netWorkRecord) =>
    _appDataBase.db.httpRequestLocalRepository.insertSimpleHttpRequest(netWorkRecord);


  void startRetry(int milliSecond){
    assert(milliSecond > 5000,'调用时间不能过短');
    _timer =  Timer.periodic(Duration(milliseconds: milliSecond), (timer) async {
        var httpRequests = await _appDataBase.db.httpRequestLocalRepository.findAllSimpleHttpRequest();
        for(SimpleHttpRequest httpRequest in httpRequests){
          var request = Request(httpRequest.method, httpRequest.url,   Config.getInstance().netWorkConfig.getDomain(),body:  jsonDecode(httpRequest.body ), headers: {});
          await Api.getInstance().getClient().send(request);
          await _appDataBase.db.httpRequestLocalRepository.deleteSimpleHttpRequest(httpRequest);
        }
    });
  }

  void stopRetry(){
    _timer?.cancel();
  }

}