import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ggc/download.dart';
import 'package:ggc/model/game_data.dart';
import 'package:ggc/ui/bought_item_screen.dart';

import '../responsive.dart';
import '../screen_transition.dart';
import '../ui/add_list_item_screen.dart';
import '../util.dart';

class GameLogic {
  static GameData gameData = GameData();
  static const String _storageFile = "GameData.json";
  static late StringStorage ss;
  static late ScrollController scrollController;
  static Future<void> init() async {
    await loadData();
    initScrollController();
  }

  static void initScrollController() {
    scrollController = ScrollController();
  }

  static Future<void> loadData() async {
    String data = "";
    try {
      ss = StringStorage(_storageFile);
      data = await ss.readFile();
      if (Util.isStringValid(data)) {
        gameData = GameData.fromJson(json.decode(data));
      } else {
        gameData = GameData();
      }
    } catch (e) {
      //
    }
  }

  static bool saveInProgress = false;
  static void saveData() {
    if (saveInProgress) {
      return;
    }
    try {
      saveInProgress = true;
      ss.writeFileSync(json.encode(gameData));
    } catch (e) {
      //
    }
    saveInProgress = false;
  }

  static List<String> getListData() {
    return gameData.listData.keys.toList();
  }

  static void setCurrentStage(int index) {
    gameData.currStage = index;
    saveData();
  }

  static void setCurrentLevel() {
    gameData.currLevel++;
    gameData.currStage = 0;
    gameData.listData = {};
    saveData();
  }

  static void addCurrency() {
    gameData.dropletCurrency += 2;
    gameData.sunCurrency += 1;
    saveData();
  }

  static void navigateFromHome(BuildContext context) {
    if (gameData.currStage == 0) {
      Navigator.push(
          context,
          ScreenTransition.slideRouteToLeft(
              AddListItemScreen.routeName, const AddListItemScreen()));
    } else {
      Navigator.push(
          context,
          ScreenTransition.slideRouteToLeft(
              BoughtItemScreen.routeName, const BoughtItemScreen()));
    }
  }

  static bool allItemBought() {
    return true;
  }

  static void scrollToActiveIndex() {
    if (GameLogic.scrollController.hasClients) {
      GameLogic.scrollController.animateTo(
        getActiveOffset(),
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  static double getActiveOffset() {
    int activeLevel = GameLogic.gameData.currLevel;
    double levelHeight = Responsive.getValueInPixel(220);
    double offset =
        (activeLevel + 4) * levelHeight - (Responsive.getDeviceHeight() / 2);
    offset = max(0, offset);
    offset =
        min((131) * levelHeight - (Responsive.getDeviceHeight() / 2), offset);
    return offset;
  }
}
