import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ggc/logic/game_logic.dart';
import 'package:ggc/ui/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../game_constant.dart';
import '../responsive.dart';
import '../util.dart';
import 'bottom_bar.dart';
import 'progression_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "/home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late ScrollButtonModel scrollButtonModel;
  Random random = Random();
  String doYouKnowText = "";
  String link = "";
  late Uri url;
  @override
  void initState() {
    int index = random.nextInt(5);
    List<String> info = GameLogic.getDoYouInfo(index);
    doYouKnowText = info[0];
    link = info[1];
    url = Uri.parse("link");
    scrollButtonModel = ScrollButtonModel(this);
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
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                const CustomAppBar(),
                Expanded(
                    child: ProgressionList(
                  scrollButtonModel: scrollButtonModel,
                )),
                BottomBar(HomeScreen.routeName),
              ],
            ),
          )),
          Positioned(
            bottom: Responsive.getDefaultHeightDim(BottomBar.height + 50),
            right: Responsive.getValueInPixel(50),
            child: ChangeNotifierProvider.value(
                value: scrollButtonModel, child: const ScrollButton()),
          ),
          doYouKnowWidget(),
        ]),
      ),
    );
  }

  Widget doYouKnowWidget() {
    return Container(
      margin: EdgeInsets.only(top: Responsive.getDefaultHeightDim(350)),
      height: Responsive.getDefaultHeightDim(340),
      padding:
          EdgeInsets.symmetric(horizontal: Responsive.getDefaultWidthDim(50)),
      child: Stack(
        children: [
          Image(
            image: Util.getLocalImage(GameConstants.doYouKnow),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Responsive.getDefaultHeightDim(300),
                width: 0.7 * Responsive.getDeviceWidth(),
                margin: EdgeInsets.only(left: Responsive.getValueInPixel(50)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DO YOU KNOW?",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: const Color(0xffF0DAFF),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontFamily: GameConstants.fontFamily,
                        fontSize: Responsive.getFontSize(60),
                      ),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.start,
                    ),
                    Container(
                      height: Responsive.getValueInPixel(10),
                    ),
                    Text(
                      doYouKnowText,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: const Color(0xffFFFFFF),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontFamily: GameConstants.fontFamily,
                        fontSize: Responsive.getFontSize(65),
                      ),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  launchURL(link);
                },
                child: Container(
                  color: Colors.transparent,
                  margin:
                      EdgeInsets.only(right: Responsive.getValueInPixel(50)),
                  width: 0.1 * Responsive.getDeviceWidth(),
                  height: Responsive.getDefaultHeightDim(100),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ScrollButtonModel extends ChangeNotifier {
  bool isVisible = false;
  bool showButton = false;
  bool scrollUp = false;
  bool scrollDown = false;
  bool disable = false;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  ScrollButtonModel(TickerProvider vsync) {
    animationController = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 200));
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        disable = false;
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void show(bool scrollup, bool scrolldown) {
    if (isVisible || disable) {
      return;
    }
    isVisible = true;
    showButton = true;
    scrollDown = scrolldown;
    scrollUp = scrollup;
    notifyListeners();
    animationController.forward(from: 0.0);
  }

  void hide() {
    if (!isVisible) {
      return;
    }
    disable = true;
    isVisible = false;
    showButton = false;
    scrollDown = false;
    scrollUp = false;
    notifyListeners();
    animationController.reverse();
  }
}

class ScrollButton extends StatefulWidget {
  const ScrollButton({super.key});

  @override
  State<ScrollButton> createState() => _ScrollButtonState();
}

class _ScrollButtonState extends State<ScrollButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollButtonModel>(builder: (context, model, _) {
      return model.showButton
          ? Container(
              width: Responsive.getValueInPixel(200),
              height: Responsive.getValueInPixel(200),
              child: Stack(children: [
                model.scrollUp
                    ? FadeTransition(
                        opacity: model.fadeAnimation,
                        child: GestureDetector(
                          onTap: () {
                            GameLogic.scrollToActiveIndex();
                            model.hide();
                          },
                          child: Container(
                            width: Responsive.getValueInPixel(215),
                            height: Responsive.getValueInPixel(228),
                            child: Image(
                                image:
                                    Util.getLocalImage(GameConstants.scrollUp)),
                          ),
                        ))
                    : Container(),
                model.scrollDown
                    ? FadeTransition(
                        opacity: model.fadeAnimation,
                        child: GestureDetector(
                          onTap: () {
                            GameLogic.scrollToActiveIndex();
                            model.hide();
                          },
                          child: Container(
                            width: Responsive.getValueInPixel(215),
                            height: Responsive.getValueInPixel(228),
                            child: Image(
                                image: Util.getLocalImage(
                                    GameConstants.scrollDown)),
                          ),
                        ))
                    : Container(),
              ]),
            )
          : Container();
    });
  }
}
