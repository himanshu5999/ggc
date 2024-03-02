import 'package:flutter/widgets.dart';

import 'game_constant.dart';
import 'responsive.dart';

class Util {
  static Future<void> init() async {
    await loadData();
  }

  static loadData() async {}

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

  static ImageProvider getResizedImage(
      ImageProvider img, double width, double height) {
    return ResizeImage(img,
        width: Responsive.getDPRValue(width).toInt(),
        height: Responsive.getDPRValue(height).toInt());
  }
}
