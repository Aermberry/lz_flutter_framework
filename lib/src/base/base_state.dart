import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lz_flutter/flutter_base.dart';
import '../widget/default_loading_dialog.dart';


abstract class BaseState<T extends StatefulWidget>  extends State<T> implements View{

  @override
  void showMsgBySnackBar(String msg) {
    Scaffold.of(getContext()).showSnackBar(SnackBar(content: new Text(msg)));
  }

  @override
  void showMsgByToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  @override
  void showLoadingDialog([String msg]) {
    showDialog(
        context: getContext(),
        builder: (context) {
          return LoadingDialog(
            text: msg,
          );
        });

  }

  @override
  void hideLoadingDialog(){
    pop();
  }

  @override
  void pop({Object result}) {
    Navigator.of(getContext()).pop(result);
  }

  @override
  void popTo(String routePath){
    Navigator.of(getContext()).popUntil(ModalRoute.withName(routePath));
  }

  @override
  Future<T> routeTo<T extends Object>(String routePath,{bool replace = false,bool clearStack = false,bool keepThisPage = false,String needKeepPageWithClearStack ,Object params}){
    if(replace){
      return Navigator.pushReplacementNamed(getContext(), routePath,arguments: params);
    } else if(clearStack){
      return Navigator.pushNamedAndRemoveUntil(getContext(), routePath, needKeepPageWithClearStack == null ?  (r) => keepThisPage : ModalRoute.withName(needKeepPageWithClearStack), arguments: params);
    }else{
      return Navigator.pushNamed(getContext(), routePath,arguments: params);
    }
  }

  @override
  BuildContext getContext() => context;

  @override
  void refresh() {
    setState(() {
      
    });
  }

}
