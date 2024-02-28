import 'package:flutter/material.dart';

import 'responsive.dart';
import 'ui/home_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    var routes = {
      HomeScreen.routeName: (context) => const HomeScreen(),
    };

    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        // fontFamily: GameConstants.fontFamily,
        // primarySwatch: MaterialColor(primary, swatch),
        // canvasColor: Colors.transparent,
      ),
    );
  }
}
