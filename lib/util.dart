import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

import 'game_constant.dart';
import 'logic/leaf_logic.dart';
import 'responsive.dart';

class Util {
  static Future<void> init() async {
    await loadData();
  }

  static loadData() async {
    await LeafLogic.loadRiveFile();
  }

  static double getTextScaleFactor() {
    return 1.0;
  }

  static ImageProvider getLocalImage(String img,
      {double? width, double? height}) {
    ImageProvider assetImage =
        AssetImage("${GameConstants.assetsImagesPath}/$img");
    if (width != null && height != null) {
      return getResizedImage(assetImage, width, height);
    }
    return assetImage;
  }

  static Directory? flutterDocumentDir;
  static Future<Directory> getFlutterDocumentDir() async {
    if (flutterDocumentDir != null) {
      return flutterDocumentDir!;
    }
    final directory = await getApplicationDocumentsDirectory();
    print("Directory info:" + directory.path);
    flutterDocumentDir = directory;
    return flutterDocumentDir!;
  }

  static ImageProvider getResizedImage(
      ImageProvider img, double width, double height) {
    return ResizeImage(img,
        width: Responsive.getDPRValue(width).toInt(),
        height: Responsive.getDPRValue(height).toInt());
  }

  static bool isStringValid(String? str) {
    return (str != null && str != "");
  }
}
