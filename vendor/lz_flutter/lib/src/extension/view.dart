import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lz_flutter/src/manager/router_manager.dart';
import 'package:lz_flutter/src/widget/default_loading_dialog.dart';

/**
 * 这个类本身为空 但是通过拓展方法添加了通用函数
 * 具体实现方法可查看 /extension/ext_view
 *  void showMsgBySnackBar(String msg)  通过SnackBar展示信息
 *  void showMsgByToast(String msg)   通过Toast展示信息
 *  void showLoadingDialog([String msg])    展示LoadingDialog
 *  void hideLoadingDialog()    隐藏LoadingDialog
 *  void pop({result})  退出当前页面 可带参数
 *  void popTo(String routePath)     返回到路由列表中的某个页面
 *  void routeTo(String routePath,{bool replace = false,bool clearStack = false,Map<String, dynamic> params,Function(Object) resultFunction})
 */
abstract class View{

  /**
   * 通过SnackBar展示信息
   */
  void showMsgBySnackBar(BuildContext context,String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(content: new Text(msg)));
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
  void showLoadingDialog(BuildContext context,[String msg]) {
    showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog(
            text: msg,
          );
        });

  }

  /**
   * 隐藏LoadingDialog
   */
  void hideLoadingDialog(BuildContext context){
    pop(context);
  }

  /**
   * 退出当前页面 可带参数
   */
  void pop(BuildContext context,{result}) {
    Navigator.of(context).pop(result);
  }

  /**
   * 返回到路由列表中的某个页面
   */
  void popTo(BuildContext context,String routePath){
    Navigator.of(context).popUntil(ModalRoute.withName(routePath));
  }


  /**
   * routePath 路由地址 /user/login
   * replace 是否移除当前page
   * params 可带参
   * clearStack 是否清除路由堆栈
   * resultFunction 需要返回值的跳转
   */
  void routeTo(BuildContext context,String routePath,{bool replace = false,bool clearStack = false,Map<String, dynamic> params,Function(Object) resultFunction}){
    RouterManager.getInstance().navigateTo(context, routePath,params: params,replace: replace,clearStack: clearStack);
  }

}
