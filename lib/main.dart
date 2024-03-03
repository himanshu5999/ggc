import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ggc/model/game_logic.dart';

import 'main_app.dart';
import 'util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initApp();
  await GameLogic.init();
  runApp(const MainApp());
}

Future<void> initApp() async {
  await Util.init();
}
