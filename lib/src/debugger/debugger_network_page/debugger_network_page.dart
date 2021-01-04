import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter/src/debugger/debugger_network_detail_page/debugger_network_detail_page.dart';
import 'package:lz_flutter/src/debugger/domain/request_result.dart';
import 'package:lz_flutter/src/network/debugger_interceptor.dart';

class DebuggerNetworkPage extends StatefulWidget {
  @override
  _DebuggerNetworkPageState createState() => _DebuggerNetworkPageState();
}

class _DebuggerNetworkPageState extends State<DebuggerNetworkPage> {
  List<RequestResult> requests;

  @override
  void initState() {
    super.initState();
    requests = networkResults.reversed.toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 5, 20),
                        child: Text('Network',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30))),
                    Hero(
                        tag: 'network_icon',
                        child: Icon(
                          Icons.network_check,
                          color: Colors.blueAccent,
                          size: 30,
                        )),
                  ],
                ),
                Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0))),
                    color: Colors.white,
                    elevation: 15,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: const [
                                CircleAvatar(
                                    radius: 6, backgroundColor: Colors.green),
                                Text(' Config',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            ),
                            Container(height: 15),
                            Row(
                              children: [
                                Container(
                                    constraints: BoxConstraints(minWidth: 70),
                                    child: Text(
                                      'Proxy: ',
                                    )),
                                Expanded(
                                    child: Text(Config.getInstance().netWorkConfig.getProxy()))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              children: [
                                Container(
                                    constraints: BoxConstraints(minWidth: 70),
                                    child: Text(
                                      'Timeout: ',
                                    )),
                                Expanded(child: Text(Config.getInstance().netWorkConfig.getConnectionTimeout().toString()))
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    constraints: BoxConstraints(minWidth: 70),
                                    child: Text(
                                      'Domain: ',
                                    )),
                                Expanded(
                                    child: Text(Config.getInstance().netWorkConfig.getDomain()))
                              ],
                            ),
                            Container(height: 10),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black.withAlpha(50),
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            ),
                            Row(
                              children: const [
                                CircleAvatar(
                                    radius: 6, backgroundColor: Colors.green),
                                Text(' Request result',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            ),
                            Container(height: 15),
                            Row(
                              children:  [
                                Expanded(
                                    child: Center(
                                        child: Text('Success: ${requests.where((element) => element.stateCode < 400).length}',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold)))),
                                Expanded(
                                    child: Center(
                                        child: Text('Fail: ${requests.where((element) => element.stateCode > 400).length}',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)))),
                              ],
                            ),
                          ],
                        ))),
                const Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Text('Log',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24))),
                Card(
                    margin: const EdgeInsets.fromLTRB(3, 5, 3, 5),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Row(
                              children: [
                                const Expanded(
                                    child: Center(
                                        child: Text(
                                  'All',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                                Container(
                                    height: 20, width: 1, color: Colors.grey),
                                Expanded(
                                    child: Center(
                                        child: Text('200',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    getStateCodeColor(200))))),
                                Container(
                                    height: 20, width: 1, color: Colors.grey),
                                Expanded(
                                    child: Center(
                                        child: Text('300',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    getStateCodeColor(300))))),
                                Container(
                                    height: 20, width: 1, color: Colors.grey),
                                Expanded(
                                    child: Center(
                                        child: Text('400',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    getStateCodeColor(400))))),
                                Container(
                                    height: 20, width: 1, color: Colors.grey),
                                Expanded(
                                    child: Center(
                                        child: Text('500',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    getStateCodeColor(500))))),
                              ],
                            ))
                      ],
                    )),
                for (RequestResult result in requests)
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  DebuggerNetworkDetailPage(result,requests.indexOf(result))));
                    },
                      child: Hero(tag: 'result${requests.indexOf(result)}', child: Card(
                          margin: const EdgeInsets.fromLTRB(3, 10, 3, 5),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          color: Colors.white,
                          elevation: 5,
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Row(
                                children: [
                                  Text(
                                    result.stateCode.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: getStateCodeColor(
                                            result.stateCode)),
                                  ),
                                  Container(width: 10),
                                  Text(result.method,
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                  Container(width: 15),
                                  Expanded(
                                      child: Text(result.methodName,
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withAlpha(210),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14))),
                                  Container(width: 10),
                                  Text(
                                      formatDate(
                                          result.time, [HH, ':', nn, ':', ss]),
                                      style: TextStyle(
                                          color: Colors.black.withAlpha(120),
                                          fontWeight: FontWeight.w600)),
                                ],
                              )))))
              ]))));

  Color getStateCodeColor(int stateCode) {
    if (stateCode < 300) {
      return Colors.green;
    } else if (stateCode < 400) {
      return Colors.orangeAccent;
    } else if (stateCode < 500) {
      return Colors.red;
    } else {
      return Colors.redAccent;
    }
  }
}
