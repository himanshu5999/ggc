import 'package:flutter/material.dart';
import 'package:ggc/logic/game_logic.dart';
import 'package:ggc/logic/leaf_logic.dart';
import 'package:ggc/screen_transition.dart';
import 'package:ggc/ui/app_bar.dart';
import 'package:ggc/ui/bottom_bar.dart';
import 'package:ggc/ui/common_widgets.dart';
import 'package:ggc/ui/home_screen.dart';
import 'package:ggc/ui/leaf_screen.dart';
import 'package:rive/rive.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../util.dart';

class OutroScreen extends StatefulWidget {
  static String routeName = "/outroScreen";
  const OutroScreen({super.key});

  @override
  State<OutroScreen> createState() => _OutroScreenState();
}

class _OutroScreenState extends State<OutroScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> boxFadeInAnimation;
  late Animation<double> textFadeInAnimation;
  late Animation<double> sunFadeOutAnimation;
  late Animation<double> dropFadeOutAnimation;
  late Animation<double> topBarFadeOutAnimation;
  late Animation<double> appBarFadeInAnimation;
  late Animation<double> sunCurrencyScaleAniamation;
  late Animation<double> sunCurrencyPosAnimation;
  late Animation<double> dropCurrencyScaleAniamation;
  late Animation<double> dropCurrencyPosAnimation;
  bool isSunRewarded = false;
  bool isDropletRewarded = false;
  late int sunCurrency;
  late int dropletCurrency;

  late double currencyInitialPos;
  late double currencyFinalPos;
  bool enebleButton = false;
  @override
  void initState() {
    sunCurrency = GameLogic.gameData.sunCurrency - GameConstants.sunReward;
    dropletCurrency =
        GameLogic.gameData.dropletCurrency - GameConstants.dropletReward;
    currencyInitialPos =
        (Responsive.getDeviceHeight() - Responsive.getValueInPixel(300)) / 2;
    currencyFinalPos =
        (Responsive.getDeviceHeight() - Responsive.getValueInPixel(300)) / 2 -
            Responsive.getValueInPixel(400);
    _initAnimationController();
    _initAnimation();
    animationController.forward();
    super.initState();
  }

  void _initAnimationController() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 7000),
    );
    animationController.addListener(() {
      if (animationController.value >= 0.45 && !isSunRewarded) {
        setState(() {
          sunCurrency = GameLogic.gameData.sunCurrency;
          isSunRewarded = true;
        });
      }
    });
    animationController.addListener(() {
      if (animationController.value >= 0.70 && !isDropletRewarded) {
        setState(() {
          dropletCurrency = GameLogic.gameData.dropletCurrency;
          isDropletRewarded = true;
        });
      }
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          enebleButton = true;
        });
      }
    });
  }

  void _initAnimation() {
    sunCurrencyPosAnimation = Tween(
      begin: currencyInitialPos,
      end: currencyFinalPos,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.55, curve: Curves.easeInOut),
      ),
    );
    dropCurrencyPosAnimation = Tween(
      begin: currencyInitialPos,
      end: currencyFinalPos,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 0.80, curve: Curves.easeInOut),
      ),
    );
    boxFadeInAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.15, 0.20, curve: Curves.easeInOut),
      ),
    );
    textFadeInAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.90, 1.0, curve: Curves.easeInOut),
      ),
    );
    appBarFadeInAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.12, 0.18, curve: Curves.easeInOut),
      ),
    );
    sunFadeOutAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.60, 0.65, curve: Curves.easeInOut),
      ),
    );
    topBarFadeOutAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.15, curve: Curves.easeInOut),
      ),
    );
    dropFadeOutAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.85, 0.90, curve: Curves.easeInOut),
      ),
    );
    sunCurrencyScaleAniamation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.4, 0.60, curve: Curves.easeInOut),
      ),
    );
    dropCurrencyScaleAniamation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.65, 0.80, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              giftBoxWidget(),
              outroTextWidget(),
            ],
          ),
          sunCurrencyWidget(),
          dropCurrencyWidget(),
          Positioned(
              child: Align(
            alignment: Alignment.topCenter,
            child: FadeTransition(
              opacity: topBarFadeOutAnimation,
              child: Column(
                children: [
                  ScreenTopBar(
                    showBack: false,
                    barValue: 1.0,
                    onBackTap: onBackTap,
                  ),
                ],
              ),
            ),
          )),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ScreenBottomBar(
                  item: enebleButton ? 1 : 0,
                  buttonText: "CONTINUE",
                  onButtonTap: onBottomButtonTap),
            ),
          ),
          Positioned(
              child: Align(
            alignment: Alignment.topCenter,
            child: FadeTransition(
                opacity: appBarFadeInAnimation,
                child: CustomAppBar(
                  sunCurrency: sunCurrency,
                  dropletCurrency: dropletCurrency,
                )),
          )),
        ]),
      ),
    );
  }

  void onBackTap() {
    Navigator.pop(context);
  }

  Widget outroTextWidget() {
    return FadeTransition(
      opacity: textFadeInAnimation,
      child: Container(
        margin: EdgeInsets.only(top: 0),
        width: Responsive.getDefaultWidthDim(1250),
        child: Text(
          "Harness the sun and water to nurture your garden's growth.",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: const Color(0xff4B4B4B),
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontFamily: GameConstants.fontFamily,
            fontSize: Responsive.getFontSize(70),
          ),
          textScaleFactor: 1.0,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget sunCurrencyWidget() {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Positioned(
            top: sunCurrencyPosAnimation.value,
            left: (Responsive.getDeviceWidth() -
                    Responsive.getValueInPixel(360)) /
                2,
            child: Transform.scale(
                scale: sunCurrencyScaleAniamation.value, child: child!),
          );
        },
        child: FadeTransition(
          opacity: sunFadeOutAnimation,
          child: Container(
            width: Responsive.getValueInPixel(360),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "+",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: const Color(0xffF19B38),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontFamily: GameConstants.fontFamily,
                        fontSize: Responsive.getFontSize(90),
                      ),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.start,
                    ),
                    Container(
                      width: Responsive.getValueInPixel(30),
                    ),
                    Image(
                        height: Responsive.getValueInPixel(150),
                        width: Responsive.getValueInPixel(150),
                        image: Util.getLocalImage(GameConstants.sunIcon)),
                  ],
                ),
                Text(
                  "${GameConstants.sunReward}",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: const Color(0xffF19B38),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontFamily: GameConstants.fontFamily,
                    fontSize: Responsive.getFontSize(90),
                  ),
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ));
  }

  Widget dropCurrencyWidget() {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Positioned(
            top: dropCurrencyPosAnimation.value,
            left: (Responsive.getDeviceWidth() -
                    Responsive.getValueInPixel(360)) /
                2,
            child: Transform.scale(
                scale: dropCurrencyScaleAniamation.value, child: child!),
          );
        },
        child: FadeTransition(
          opacity: dropFadeOutAnimation,
          child: Container(
            width: Responsive.getValueInPixel(360),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "+",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: const Color(0xff53AEF0),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontFamily: GameConstants.fontFamily,
                        fontSize: Responsive.getFontSize(90),
                      ),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.start,
                    ),
                    Container(
                      width: Responsive.getValueInPixel(30),
                    ),
                    Image(
                        height: Responsive.getValueInPixel(150),
                        width: Responsive.getValueInPixel(150),
                        image: Util.getLocalImage(GameConstants.droplet)),
                  ],
                ),
                Text(
                  "${GameConstants.dropletReward}",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: const Color(0xff53AEF0),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontFamily: GameConstants.fontFamily,
                    fontSize: Responsive.getFontSize(90),
                  ),
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ));
  }

  Widget giftBoxWidget() {
    return FadeTransition(
      opacity: boxFadeInAnimation,
      child: Container(
        color: Colors.transparent,
        height: Responsive.getValueInPixel(1000),
        width: Responsive.getValueInPixel(1000),
        child: RiveAnimation.asset(
          GameConstants.getLocalAnimationPath(GameConstants.boxRive),
          animations: const [GameConstants.boxAniamtion],
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  void onBottomButtonTap() {
    if (!enebleButton) {
      return;
    }
    if (LeafLogic.canUpgradeTree()) {
      BottomBar.jewelNotifModel.showNotif(LeafScreen.routeName);
    }
    popUntilRoot();
    Navigator.push(context,
        ScreenTransition.fadeRoute(HomeScreen.routeName, HomeScreen()));
  }

  void popUntilRoot() {
    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
      popUntilRoot();
    }
  }
}
