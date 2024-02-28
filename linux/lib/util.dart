import 'package:flutter/services.dart';

class Util {
  static Future<void> init() async {
    await loadData();
  }
  
  static loadData() async {
  }
  
  static double getTextScaleFactor() {
    return 1.0;
  }
}