import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ggc/download.dart';
import 'package:ggc/logic/leaf_logic.dart';
import 'package:ggc/model/game_data.dart';
import 'package:ggc/ui/bottom_bar.dart';
import 'package:ggc/ui/bought_item_screen.dart';
import 'package:ggc/ui/leaf_screen.dart';

import '../responsive.dart';
import '../screen_transition.dart';
import '../ui/add_list_item_screen.dart';
import '../util.dart';

class GameLogic {
  static GameData gameData = GameData();
  static const String _storageFile = "GameData.json";
  static late StringStorage ss;
  static late ScrollController scrollController;
  static Map<String, String> doYouKnowText = {
    "A reusable bag needs to be used at least 131 times":
        "https://edition.cnn.com/2023/03/13/world/reusable-grocery-bags-cotton-plastic-scn/index.html",
    "India generates 26,000 tonnes of plastic waste daily":
        "https://www.sciencedirect.com/science/article/abs/pii/S2214785323020539",
    "Plastic usage is higher among the people who follow unsanitary methods of disposal":
        "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10616534/",
    "Only 10-14% of plastics will be recycled by 2030":
        "https://www.ellenmacarthurfoundation.org/plastics-and-the-circular-economy-deep-dive",
    "Plastics crisis requires reducing use and improving material sustainability":
        "https://www.nature.com/articles/s41893-023-01236-z"
  };
  static Future<void> init() async {
    await loadData();
    initScrollController();
    addJewelNotif();
  }

  static void addJewelNotif() {
    if (LeafLogic.canUpgradeTree()) {
      BottomBar.jewelNotifModel.showNotif(LeafScreen.routeName);
    }
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
    Navigator.push(
        context,
        ScreenTransition.slideRouteToLeft(
            AddListItemScreen.routeName, const AddListItemScreen()));
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

  static List<String> getDoYouInfo(int index) {
    List<String> info = [];
    String text = doYouKnowText.keys.elementAt(index);
    String link = doYouKnowText[text] ?? "";
    info.add(text);
    info.add(link);
    return info;
  }
}
