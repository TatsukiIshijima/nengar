import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nengar/gen/colors.gen.dart';

// FIXME: iOSテーマ対応
const CupertinoThemeData nengarCupertinoTheme = CupertinoThemeData(
  primaryColor: ColorName.primaryColor,
);

ThemeData nengarMaterialLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'NotoSerifJP',
  primarySwatch: MaterialColor(
    ColorName.primaryColor.value,
    const <int, Color>{
      // secondaryHeaderColor
      50: ColorName.backgroundLightColor,
      // primaryColorLight
      100: ColorName.primaryLightColor,
      // backgroundColor, textSelectionColor
      200: ColorName.backgroundLightColor,
      // textSelectionHandleColor
      300: ColorName.backgroundLightColor,
      400: ColorName.backgroundLightColor,
      // accentColor
      500: ColorName.secondaryColor,
      // use toggleableActiveColor if accentColor is null
      600: ColorName.secondaryColor,
      // primaryColorDark
      700: ColorName.primaryDarkColor,
      800: ColorName.backgroundLightColor,
      // primaryColor
      900: ColorName.primaryColor,
    },
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: ColorName.primaryColor,
    disabledColor: Colors.black38,
  ),
);

// FIXME:ダークモード対応
ThemeData nengarMaterialDarkTheme = ThemeData(
  fontFamily: 'NotoSerifJP',
  brightness: Brightness.dark,
);