import 'package:flutter/services.dart';
import 'package:ggc/game_constant.dart';
import 'package:rive/rive.dart';

class LeafLogic {
  static late RiveFile riveFile;

  static Future<void> loadRiveFile() async {
    ByteData data = await rootBundle.load(GameConstants.getLocalAnimationPath(GameConstants.treeRive));
    riveFile = RiveFile.import(data);
  }
}
