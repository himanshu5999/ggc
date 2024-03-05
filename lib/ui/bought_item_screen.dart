import 'package:flutter/material.dart';
import 'package:ggc/logic/game_logic.dart';
import 'package:ggc/ui/common_widgets.dart';
import 'package:ggc/ui/home_screen.dart';
import 'package:ggc/ui/outro_screen.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../screen_transition.dart';
import '../util.dart';

class BoughtItemScreen extends StatefulWidget {
  static String routeName = "/boughtItem";
  const BoughtItemScreen({super.key});

  @override
  State<BoughtItemScreen> createState() => _BoughtItemScreenState();
}

class _BoughtItemScreenState extends State<BoughtItemScreen> {
  List<String> items = [];
  bool allItemBought = false;

  @override
  void initState() {
    if (GameLogic.allItemBought()) {
      allItemBought = true;
    }
    items = GameLogic.getListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: Responsive.getDeviceWidth(),
          height: Responsive.getDeviceHeight(),
          child: Stack(fit: StackFit.expand, children: [
            Image(
              width: Responsive.getDeviceWidth(),
              height: Responsive.getDeviceHeight(),
              image: Util.getLocalImage(GameConstants.background),
              fit: BoxFit.fill,
            ),
            Positioned(
                child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  ScreenTopBar(
                    barValue: 0.7,
                    onBackTap: onBackTap,
                  ),
                  listWidget(),
                ],
              ),
            )),
            Positioned(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: ScreenBottomBar(
                  item: !allItemBought ? 0 : 1,
                  buttonText: "GOT THE ITEMS",
                  onButtonTap: onBottomButtonTap),
            )),
          ])),
    );
  }

  void onBackTap() {
    Navigator.pop(context);
  }

  Widget listWidget() {
    return Expanded(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.only(top: Responsive.getValueInPixel(40)),
                  padding: EdgeInsets.only(
                      left: Responsive.getValueInPixel(50),
                      right: Responsive.getValueInPixel(50)),
                  child: Stack(children: [
                    Image(image: Util.getLocalImage(GameConstants.listTile)),
                    Container(
                      padding: EdgeInsets.only(
                          left: Responsive.getValueInPixel(50),
                          top: Responsive.getValueInPixel(80)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              onButtonTap(index);
                            },
                            child: Image(
                              width: Responsive.getValueInPixel(90),
                              height: Responsive.getValueInPixel(90),
                              image: Util.getLocalImage(
                                  GameLogic.gameData.listData[items[index]]!
                                      ? GameConstants.done
                                      : GameConstants.check),
                            ),
                          ),
                          Container(
                            width: Responsive.getValueInPixel(50),
                          ),
                          Text(
                            items[index],
                            style: TextStyle(
                              decoration:
                                  GameLogic.gameData.listData[items[index]]!
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                              color: const Color(0xff4B4B4B),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontFamily: GameConstants.fontFamily,
                              fontSize: Responsive.getFontSize(70),
                            ),
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    )
                  ]));
            }));
  }

  void onButtonTap(int index) {
    GameLogic.gameData.listData[items[index]] = true;
    GameLogic.saveData();
    setState(() {
      if (GameLogic.allItemBought()) {
        allItemBought = true;
      }
    });
  }

  void onBottomButtonTap() {
    if (!allItemBought) {
      return;
    }
    GameLogic.setCurrentLevel();
    GameLogic.addCurrency();
    Navigator.pushReplacement(context,
        ScreenTransition.fadeRoute(OutroScreen.routeName, const OutroScreen()));
  }
}
