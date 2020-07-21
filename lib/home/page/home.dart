import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';
import 'package:lz_flutter/flutter_base.dart';

@provide
class HomePage extends StatelessWidget implements View {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container();
  }

  @override
  BuildContext getContext() => _context;
}
