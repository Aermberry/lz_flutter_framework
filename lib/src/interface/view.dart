import 'package:flutter/cupertino.dart';

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

  BuildContext getContext();

}