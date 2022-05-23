import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

enum RandomColorMode { dark, light, random }

class ConfigColor {
  static final Color primaryColor = getColorFromHex('#017DF0');
  static final Color primaryColorVariant = getColorFromHex('#002916');
  static final Color secondaryColor = getColorFromHex('#F5D650');
  static final Color secondaryColorVariant = getColorFromHex('#D68D18');
  static final Color backgroundColor = getColorFromHex('#0286EF');
  static final Color disabledColor = Colors.grey.shade400;

  static const Color primaryTextColor = Colors.black;
  static const Color secondaryTextColor = Colors.white;

  static final Color successColor = getColorFromHex('#77DD77');
  static final Color errorColor = getColorFromHex('#FF6961');
  static final Color infoColor = getColorFromHex('#1AA7EC');

  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }

    return Colors.black;
  }

  static Color getRandomColor(RandomColorMode mode) {
    if (mode == RandomColorMode.dark) {
      return RandomColor().randomColor(
          colorBrightness: ColorBrightness.dark,
          colorSaturation: ColorSaturation.mediumSaturation,
          colorHue: ColorHue.random);
    } else if (mode == RandomColorMode.light) {
      return RandomColor().randomColor(
          colorBrightness: ColorBrightness.light,
          colorSaturation: ColorSaturation.lowSaturation,
          colorHue: ColorHue.random);
    }
    return RandomColor().randomColor();
  }  
}