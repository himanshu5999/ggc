import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ggc/game_constant.dart';
import 'package:ggc/logic/game_logic.dart';
import 'package:rive/rive.dart';

class LeafLogic {
  static const String treeJsonFile = "tree_data.json";
  static late RiveFile riveFile;
  static bool _initDone = false;
  static Map<String, Map<String, dynamic>> treeData = {};

  static Future<void> init() async {
    if (_initDone) {
      return;
    }
    await loadRiveFile();
    await loadTreeData();
    _initDone = true;
  }

  static Future<void> loadTreeData() async {
    String data = await rootBundle
        .loadString(GameConstants.getLocalConfigPath(treeJsonFile));
    treeData = {...json.decode(data)};
  }

  static Future<void> loadRiveFile() async {
    ByteData data = await rootBundle
        .load(GameConstants.getLocalAnimationPath(GameConstants.treeRive));
    riveFile = RiveFile.import(data);
  }

  static void completeLevel() {
    GameLogic.gameData.currTreeLevel++;
    GameLogic.saveData();
  }

  static int getCurrTreeLevel() {
    return GameLogic.gameData.currTreeLevel;
  }

  static bool isEOC() {
    return treeData.length <= getCurrTreeLevel();
  }

  static int nextLevelSunNeeded() {
    String level = (getCurrTreeLevel() + 1).toString();
    if (treeData.containsKey(level)) {
      Map<String, dynamic>? data = treeData[level];
      return data!["s"] ?? 0;
    }
    return 0;
  }

  static int nextLevelWaterNeeded() {
    String level = (getCurrTreeLevel() + 1).toString();
    if (treeData.containsKey(level)) {
      return treeData[level]!["w"] ?? 0;
    }
    return 0;
  }

  static double nextLevelTriggerVal() {
    String level = (getCurrTreeLevel() + 1).toString();
    if (treeData.containsKey(level)) {
      return treeData[level]!["t"] ?? 0.0;
    }
    return 0.0;
  }

  static double currLevelTriggerVal() {
    String level = (getCurrTreeLevel()).toString();
    if (treeData.containsKey(level)) {
      return treeData[level]!["t"] ?? 0;
    }
    return 0.0;
  }

  static bool canUpgradeTree() {
    int sunNeeded = nextLevelSunNeeded();
    int waterNeeded = nextLevelWaterNeeded();
    return GameLogic.gameData.dropletCurrency >= waterNeeded &&
        GameLogic.gameData.sunCurrency >= sunNeeded;
  }

  static currnecyDecrement() {
    int sunNeeded = nextLevelSunNeeded();
    int waterNeeded = nextLevelWaterNeeded();
    GameLogic.gameData.dropletCurrency -= waterNeeded;
    GameLogic.gameData.sunCurrency -= sunNeeded;
    GameLogic.saveData();
  }
}
