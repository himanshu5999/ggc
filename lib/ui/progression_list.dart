import 'package:flutter/material.dart';
import 'package:ggc/logic/game_logic.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../util.dart';

class ProgressionList extends StatefulWidget {
  static List<double> listMargin = [
    0,
    -120,
    0,
    120,
    240,
    120,
    0,
    -120,
    -240,
    -360,
    -240,
    -120,
    0
  ];

  const ProgressionList({super.key});

  @override
  State<ProgressionList> createState() => _ProgressionListState();
}

class _ProgressionListState extends State<ProgressionList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: Responsive.getValueInPixel(100)),
      itemCount: 131,
      reverse: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) =>
          tileWidget(index == GameLogic.gameData.currLevel, index),
    );
  }

  Widget tileWidget(bool selectedIndex, int index) {
    return Container(
      margin: EdgeInsets.only(top: Responsive.getValueInPixel(10)),
      width: Responsive.getDeviceWidth(),
      height: selectedIndex
          ? Responsive.getValueInPixel(330)
          : Responsive.getValueInPixel(220),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (index == GameLogic.gameData.currLevel) {
                GameLogic.navigateFromHome(context);
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: Responsive.getDeviceWidth() / 2 +
                      Responsive.getDefaultWidthDim(ProgressionList.listMargin[
                          index % ProgressionList.listMargin.length]) -
                      Responsive.getValueInPixel(330) / 2),
              child: Stack(children: [
                index == GameLogic.gameData.currLevel
                    ? testWidget()
                    : Container(),
                Center(
                  child: Container(
                    width: Responsive.getValueInPixel(310),
                    height: Responsive.getValueInPixel(310),
                    child: Stack(children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Responsive.getValueInPixel(20)),
                          child: Image(
                              width: Responsive.getValueInPixel(235),
                              height: Responsive.getValueInPixel(215),
                              image: index <= GameLogic.gameData.currLevel
                                  ? Util.getLocalImage(
                                      GameConstants.levelButtom)
                                  : Util.getLocalImage(
                                      GameConstants.freezedLevel)),
                        ),
                      ),
                      if (index >= GameLogic.gameData.currLevel)
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: Responsive.getValueInPixel(20),
                                bottom: Responsive.getValueInPixel(10)),
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: index <= GameLogic.gameData.currLevel
                                    ? const Color(0xffffffff)
                                    : const Color(0x0052656d).withOpacity(0.5),
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: Responsive.getFontSize(126),
                              ),
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      else
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: Responsive.getValueInPixel(20),
                                bottom: Responsive.getValueInPixel(10)),
                            child: Image(
                                width: Responsive.getValueInPixel(100),
                                height: Responsive.getValueInPixel(80),
                                image: Util.getLocalImage(GameConstants.tick)),
                          ),
                        )
                    ]),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget testWidget() {
    return CircularPercentIndicator(
      radius: Responsive.getValueInPixel(330) / 2,
      lineWidth: Responsive.getValueInPixel(30),
      percent: 0.3,
      backgroundColor: Color(0x002C383F).withOpacity(1),
      progressColor: Color(0x00CE82FF).withOpacity(1),
    );
  }
}
