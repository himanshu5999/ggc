import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../screen_transition.dart';
import '../util.dart';
import 'home_screen.dart';
import 'leaf_screen.dart';
import 'store_screen.dart';

enum JewelNotifType { red, green }

class BottomBar extends StatelessWidget {
  static JewelNotifModel jewelNotifModel = JewelNotifModel();
  static const double height = 280;
  static const double width = 1440;
  static Map<String, Widget> screens = {
    HomeScreen.routeName: const HomeScreen(),
    LeafScreen.routeName: const LeafScreen(),
    StoreScreen.routeName: const StoreScreen()
  };
  final double iconBlockWidth = width / screens.length;
  final String screenName;

  BottomBar(this.screenName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.only(
        topLeft: Radius.circular(Responsive.getValueInPixel(14)),
        topRight: Radius.circular(Responsive.getValueInPixel(14)));

    return Container(
        decoration:
            BoxDecoration(borderRadius: borderRadius, color: Colors.white),
        child: SizedBox(
            height: Responsive.getDefaultHeightDim(height),
            width: Responsive.getDefaultWidthDim(width),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: borderRadius,
                  child: SizedBox(
                      height: Responsive.getDefaultHeightDim(height),
                      width: Responsive.getDefaultWidthDim(width),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    _getBottomBarList(context, screenName),
                              ),
                            ]),
                          ])),
                ),
              ],
            )));
  }

  List<Widget> _getBottomBarList(context, screenName) {
    List<Widget> widgets = [];
    for (String routeName in screens.keys) {
      widgets.add(ChangeNotifierProvider.value(
        value: jewelNotifModel,
        child: _getBottomBarElement(
            context, routeName, screens[routeName]!, screenName),
      ));
    }
    return widgets;
  }

  Widget _getBottomBarElement(BuildContext context, String name,
      Widget screenWidget, String screenName) {
    return GestureDetector(
        onTap: () {
          onTap(context, name, screenName, screenWidget);
        },
        child: SizedBox(
            height: Responsive.getValueInPixel(height),
            width: Responsive.getDefaultWidthDim(iconBlockWidth),
            child: Stack(children: [
              getIconWidget(name, name == screenName),
              jewelNotifWidget(iconBlockWidth, name),
            ])));
  }

  Widget getIconWidget(String screen, bool selected) {
    return Center(
      child: Container(
        color: Colors.transparent,
        width: Responsive.getValueInPixel(350),
        height: Responsive.getValueInPixel(350),
        child: Stack(
          children: [
            if (selected)
              Center(
                child: Image(
                    width: Responsive.getValueInPixel(150),
                    height: Responsive.getValueInPixel(150),
                    image: Util.getLocalImage(GameConstants.bottomSelected)),
              ),
            Center(
              child: Container(
                width: Responsive.getValueInPixel(100),
                height: Responsive.getValueInPixel(100),
                child: Image(
                    image: Util.getLocalImage(screenImage(screen, selected))),
              ),
            )
          ],
        ),
      ),
    );
  }

  String screenImage(String screen, bool selected) {
    if (screen == HomeScreen.routeName) {
      if (selected) {
        return GameConstants.selectedHome;
      } else {
        return GameConstants.home;
      }
    } else if (screen == LeafScreen.routeName) {
      if (selected) {
        return GameConstants.selectedLeaf;
      } else {
        return GameConstants.leaf;
      }
    } else {
      if (selected) {
        return GameConstants.selectedStore;
      } else {
        return GameConstants.store;
      }
    }
  }

  bool hideJewelNotif(String route, JewelNotifModel model) {
    return model.screenRoute.isEmpty || !model.screenRoute.contains(route);
  }

  Widget jewelNotifWidget(double iconSize, String route) {
    return Consumer<JewelNotifModel>(builder: (context, model, _) {
      if (hideJewelNotif(route, model)) {
        return Container();
      }
      return Positioned(
        top: Responsive.getValueInPixel(60),
        left: Responsive.getValueInPixel(50 + iconBlockWidth / 2),
        child: Image(
          height: Responsive.getValueInPixel(50),
          image: Util.getLocalImage(GameConstants.jewelNotif),
          fit: BoxFit.contain,
        ),
      );
    });
  }

  void onTap(BuildContext context, String toScreen, String fromScreen,
      Widget screenWidget) {
    if (toScreen == fromScreen) {
      return;
    }
    Navigator.pushReplacement(
        context, ScreenTransition.fadeRoute(toScreen, screenWidget));
  }
}

class JewelNotifModel extends ChangeNotifier {
  List<String> screenRoute = [];

  static const Map<JewelNotifType, Color> colorMap = {
    JewelNotifType.red: Colors.red,
    JewelNotifType.green: Colors.green
  };

  void showNotif(String notifScreenRoute) {
    if (!screenRoute.contains(notifScreenRoute)) {
      screenRoute.add(notifScreenRoute);
      notifyListeners();
    }
  }

  void hideNotif(String notifScreenRoute) {
    if (screenRoute.contains(notifScreenRoute)) {
      screenRoute.remove(notifScreenRoute);
      notifyListeners();
    }
  }

  bool canHide(String route) {
    return screenRoute.isEmpty || !screenRoute.contains(route);
  }
}
