import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widget/default_loading_dialog.dart';

abstract class View {

  BuildContext getContext();

  void showMsgBySnackBar(String msg);

  void showMsgByToast(String msg);

  void showLoadingDialog([String msg]);

  void hideLoadingDialog();

  void pop({result});

  void popTo(String routePath);

  Future<T> routeTo<T extends Object>(String routePath,{bool replace = false,bool clearStack = false,bool keepThisPage = false, Object params});

}