import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:lz_flutter/src/debugger/debugger_main_page/debugger_main_page.dart';
import 'package:lz_flutter/src/interface/i_debugger_config.dart';

class DebuggerConfig extends IDebuggerConfig {

  OverlayEntry overlayEntry;

  @override
  void showDebuggerFloatingButton(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addOverlayEntry(context,MediaQuery.of(context).size.width - 80,
          MediaQuery.of(context).size.height - 80);
    });
  }

  Future addOverlayEntry(BuildContext context,double left, double top) async {
    var showIcon = true;
    overlayEntry?.remove();
    var icon = FloatingActionButton(
        heroTag: null,
        mini: true,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return  DebuggerMainPage();
          }));
        },
        child: Icon(Icons.bug_report, color: Colors.blueAccent),
        backgroundColor: Colors.white);
    overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
          top: top,
          left: left,
          child: GestureDetector(
              onTap: () async {},
              child: Draggable(
                  onDragStarted: () {
                    showIcon = false;
                  },
                  onDragEnd: (DraggableDetails details) {
                    ///拖动结束
                    addOverlayEntry(context, details.offset.dx, details.offset.dy);
                  },

                  ///feedback是拖动时跟随手指滑动的Widget。
                  feedback: icon,

                  ///child是静止时显示的Widget，
                  child: showIcon ? icon : Container())),
        ));
    navigatorKey.currentState.overlay.insert(overlayEntry);
  }

}