import 'package:bergverse/app/injection.dart';
import 'package:flutter/material.dart';

import 'app/my_app.dart';

void main() {
  setupInjection();
  runApp(MyApp());
}
