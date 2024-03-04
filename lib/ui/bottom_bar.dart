import 'package:flutter/material.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../screen_transition.dart';
import '../util.dart';
import 'home_screen.dart';
import 'leaf_screen.dart';
import 'store_screen.dart';

class BottomBar extends StatelessWidget {
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
      widgets.add(_getBottomBarElement(
          context, routeName, screens[routeName]!, screenName));
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
            ])));
  }

  Widget getIconWidget(String screen, bool selected) {
    return Center(
      child: Container(
        width: Responsive.getValueInPixel(150),
        height: Responsive.getValueInPixel(150),
        child: Stack(
          children: [
            if (selected)
              Image(image: Util.getLocalImage(GameConstants.bottomSelected)),
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

  void onTap(BuildContext context, String toScreen, String fromScreen,
      Widget screenWidget) {
    if (toScreen == fromScreen) {
      return;
    }
    if (toScreen == HomeScreen.routeName) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacement(
            context, ScreenTransition.fadeRoute(toScreen, screenWidget));
      }
    } else {
      Navigator.pushReplacement(
          context, ScreenTransition.fadeRoute(toScreen, screenWidget));
    }
  }
}
