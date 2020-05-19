import 'package:flutter/material.dart';
import '../widget/stateful_page.dart';


extension ExtStatefulWidget on State{

  StatefulWidget getPage() =>  StatefulPage(this);

}