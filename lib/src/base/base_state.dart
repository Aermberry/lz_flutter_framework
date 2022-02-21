import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lz_flutter/flutter_base.dart';
import '../widget/default_loading_dialog.dart';

// final getIt = GetIt.instance;

abstract class BaseState<T extends StatefulWidget>  extends State<T> implements View{

  @override
  void showMsgBySnackBar(String msg,{bool needLocal = false}) {
    if(needLocal){
      msg = msg.resLocal(getContext());
    }
    Scaffold.of(getContext()).showSnackBar(SnackBar(content: new Text(msg)));
  }

  @override
  void showMsgByToast(String msg,{bool needLocal = false}) {
    if(needLocal){
      msg = msg.resLocal(getContext());
    }
    Fluttertoast.showToast(msg: msg);
  }

  @override
  void showLoadingDialog({String? msg, bool needLocal = false, bool barrierDismissible = false}) {
    if(msg!=null && needLocal){
      msg = msg.resLocal(getContext());
    }
    showDialog(
        barrierDismissible: barrierDismissible,
        context: getContext(),
        builder: (context) {
          return LoadingDialog(
            text: msg,
          );
        });

  }

  @override
  void hideLoadingDialog({bool rootNavigator = false}){
    pop(rootNavigator: rootNavigator);
  }

  @override
  void pop({Object? result,bool rootNavigator = false}) {
    Navigator.of(getContext(),rootNavigator: rootNavigator).pop(result);
  }

  @override
  void popTo(String routePath){
    Navigator.of(getContext()).popUntil(ModalRoute.withName(routePath));
  }

  @override
  Future<T?> routeTo<T extends Object?>(Route<T> newRoute,{bool replace = false,bool clearStack = false,RoutePredicate? predicate,bool rootNavigator = false}) async {
    NavigatorState  navigatorState = Navigator.of(getContext(),rootNavigator: rootNavigator);
    if(replace){
      return navigatorState.pushReplacement(newRoute);
    } else if(clearStack){
      return navigatorState.pushAndRemoveUntil(newRoute, predicate ?? (route) => false);
    }else{
      return navigatorState.push<T>(newRoute);
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

// abstract class BaseMVPState<T extends StatefulWidget,P extends BaseMvpPresenter>  extends BaseState<T> {
//
//   late P presenter;
//
//   @override
//   void initState() {
//     presenter = getIt<P>();
//     presenter.bind(this);
//     presenter.initState();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     presenter.dispose();
//     super.dispose();
//   }
//
// }
