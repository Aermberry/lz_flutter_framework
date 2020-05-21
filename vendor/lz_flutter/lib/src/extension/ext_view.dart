import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../interface/view.dart';
import '../manager/router_manager.dart';
import '../widget/default_loading_dialog.dart';


extension ExtView on View{

  /**
   * 通过SnackBar展示信息
   */
  void showMsgBySnackBar(String msg) {
    Scaffold.of(getContext()).showSnackBar(SnackBar(content: new Text(msg)));
  }

  /**
   * 通过Toast展示信息
   */
  void showMsgByToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  /**
   * 展示LoadingDialog
   */
  void showLoadingDialog([String msg]) {
    showDialog(
        context: getContext(),
        builder: (context) {
          return LoadingDialog(
            text: msg,
          );
        });

  }

  /**
   * 隐藏LoadingDialog
   */
  void hideLoadingDialog(){
    pop();
  }

  /**
   * 退出当前页面 可带参数
   */
  void pop({result}) {
    Navigator.of(getContext()).pop(result);
  }

  /**
   * 返回到路由列表中的某个页面
   */
  void popTo(String routePath){
    Navigator.of(getContext()).popUntil(ModalRoute.withName(routePath));
  }


  /**
   * routePath 路由地址 /user/login
   * replace 是否移除当前page
   * params 可带参
   * clearStack 是否清除路由堆栈
   * resultFunction 需要返回值的跳转
   */
  void routeTo(String routePath,{bool replace = false,bool clearStack = false,Map<String, dynamic> params,Function(Object) resultFunction}){
    RouterManager.getInstance().navigateTo(getContext(), routePath,params: params,replace: replace,clearStack: clearStack);
  }


}