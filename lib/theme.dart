import 'package:flutter/cupertino.dart';
import 'package:nengar/gen/colors.gen.dart';

const CupertinoThemeData nengarThemeData = CupertinoThemeData(
  primaryColor: CupertinoDynamicColor.withBrightness(
    color: ColorName.colorPrimary,
    darkColor: ColorName.colorPrimaryDark,
  ),
);
