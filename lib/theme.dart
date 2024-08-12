import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nengar/gen/colors.gen.dart';
import 'package:nengar/gen/fonts.gen.dart';

MaterialBasedCupertinoThemeData nengarCupertinoLightTheme =
    MaterialBasedCupertinoThemeData(materialTheme: nengarMaterialLightTheme);

MaterialBasedCupertinoThemeData nengarCupertinoDarkTheme =
    MaterialBasedCupertinoThemeData(materialTheme: nengarMaterialDarkTheme);

ThemeData nengarMaterialLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: FontFamily.notoSerifJP,
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
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: ColorName.primaryDarkColor,
      backgroundColor: ColorName.primaryColor,
      disabledForegroundColor: Colors.black38,
      disabledBackgroundColor: Colors.black38,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: ColorName.primaryColor,
    selectionColor: ColorName.primaryColor,
    selectionHandleColor: ColorName.primaryColor,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorName.primaryColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: FontFamily.notoSerifJP,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: ColorName.primaryDarkColor,
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
);

// FIXME:ダークモード対応
ThemeData nengarMaterialDarkTheme = ThemeData(
  fontFamily: FontFamily.notoSerifJP,
  brightness: Brightness.dark,
);
