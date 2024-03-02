import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../screen_transition.dart';
import '../util.dart';
import 'add_list_item_screen.dart';

class ProgressionList extends StatefulWidget {
  static const selectedIndex = 1;
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
      itemCount: 131,
      reverse: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) =>
          tileWidget(index == ProgressionList.selectedIndex, index),
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
              _onTap(index);
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: Responsive.getDeviceWidth() / 2 +
                      Responsive.getDefaultWidthDim(ProgressionList.listMargin[
                          index % ProgressionList.listMargin.length]) -
                      Responsive.getValueInPixel(330) / 2),
              child: Stack(children: [
                index == ProgressionList.selectedIndex
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
                              image: index <= ProgressionList.selectedIndex
                                  ? Util.getLocalImage(
                                      GameConstants.levelButtom)
                                  : Util.getLocalImage(
                                      GameConstants.freezedLevel)),
                        ),
                      ),
                      if (index >= ProgressionList.selectedIndex)
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: Responsive.getValueInPixel(20),
                                bottom: Responsive.getValueInPixel(10)),
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: index <= ProgressionList.selectedIndex
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
      percent: 0.5,
      backgroundColor: Color(0x002C383F).withOpacity(1),
      progressColor: Color(0x00CE82FF).withOpacity(1),
    );
  }

  void _onTap(int index) {
    if (index == ProgressionList.selectedIndex) {
      Navigator.push(
          context,
          ScreenTransition.slideRouteToLeft(
              AddListItemScreen.routeName, const AddListItemScreen()));
    }
  }
}
