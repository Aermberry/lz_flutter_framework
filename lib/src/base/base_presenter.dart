import 'package:lz_flutter/src/interface/view.dart';

import '../../flutter_base.dart';

abstract class BaseMvpPresenter<T extends View> extends Lifecycle{

  late T view;

  void bind(T view){
    this.view = view;
  }

  void initState(){

  }

  void dispose(){

  }



}