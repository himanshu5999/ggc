import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main_app.dart';
import 'util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initApp();
  runApp(const MainApp());
}

Future<void> initApp() async {
  await Util.init();
}
