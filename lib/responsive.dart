import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

class Responsive {
  static late BuildContext context;
  static late Size size;
  static double totalWidth = 0;
  static double totalHeight = 0;
  static late double tileWidth;
  static double designHeight = 2560;
  static double designWidth = 1440;
  static double? devicePixelRatio;

  /// [MediaQuery] instance
  static late MediaQueryData _mediaQueryData;

  /// Screen Width
  static double? width;

  /// Screen Height
  static double? height;

  /// Width per Block
  static double? widthBlock;

  /// Height per Block
  static double? heightBlock;

  /// Base Font Size
  static double? baseFontSize;

  /// Width outside the Horizontal Safe Area
  static late double _safeAreaHorizontal;

  /// Height outside the Horizontal Safe Area
  static late double _safeAreaVertical;

  /// Screen Safe Area Width
  static late double safeWidth;

  /// Screen Safe Area Height
  static late double safeHeight;

  /// Safe Area Width per Block
  static double? safeWidthBlock;

  /// Safe Area Height per Block
  static late double safeHeightBlock;

  /// Top Height outside the Safe Area
  static late double paddingTop;

  /// padding for all devices with notches when system chrome overlays are enabled
  static double paddingNotch = -1;

  /// Bottom Height outside the Safe Area
  static double? paddingBottom;

  static void init(BuildContext c, [double designWidth = 1440, double designHeight = 2560]) {
    context = c;
    designWidth = designWidth;
    designHeight = designHeight;
    _mediaQueryData = MediaQuery.of(context);
    size = _mediaQueryData.size;
    totalWidth = size.width;
    totalHeight = size.height;
    tileWidth = totalWidth / 9.0;

    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    widthBlock = width! / 100;
    heightBlock = height! / 100;

    paddingTop = _mediaQueryData.padding.top;
    paddingBottom = _mediaQueryData.padding.bottom;

    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = paddingTop + paddingBottom!;

    safeWidth = width! - _safeAreaHorizontal;
    safeHeight = height! - _safeAreaVertical;

    safeWidthBlock = safeWidth / 100;
    safeHeightBlock = safeHeight / 100;
    baseFontSize = safeHeightBlock / 10;
    // print("Responsive: ");
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
    print("Responsive: $safeHeight $safeWidth $width $height $paddingTop $paddingBottom");
  }

  static bool checkAndSetPaddingNotch() {
    if (paddingNotch == -1) {
      paddingNotch = _mediaQueryData.padding.top;
      return true;
    }
    return false;
  }

  static double getDevicePixelRatio() {
    return devicePixelRatio ?? 1;
  }

  static getDPRValue(double val) {
    return val * getDevicePixelRatio();
  }

  static double getDeviceWidth() {
    return totalWidth;
  }

  static double getDeviceHeight() {
    return totalHeight;
  }

  // Function for getting dimension value by passing value according to 1440 width mocks
  static double getDefaultWidthDim(double value) {
    return (value / designWidth) * width!;
  }

  static double getDefaultHeightDim(double value) {
    return (value / designHeight) * height!;
  }

  // In value we are passing font size in pixel.
  static double getFontSize(double value) {
    return getValueInPixel(value);
  }

  // Function for all type of dimensions
  static double getValueInPixel(double value) {
    return min((value / designWidth) * width!, (value / designHeight) * height!);
  }

  static double getMockDimForFlutterDim(double value) {
    return value / (min(width! / designWidth, height! / designHeight));
  }
}
