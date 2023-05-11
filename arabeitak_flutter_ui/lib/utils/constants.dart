import 'package:arabeitak_flutter_ui/utils/utils.dart';
import 'package:flutter/material.dart';

Color kAppPrimaryColor = Colors.green[300]!;

ThemeData kDarkThemeData = ThemeData.dark().copyWith(
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white70,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white70,
  ),
  primaryColor: kAppPrimaryColor,
  colorScheme: ColorScheme.fromSwatch(
      primarySwatch: createMaterialColor(kAppPrimaryColor)),
);

ThemeData kLightThemeData = ThemeData(
  primarySwatch: createMaterialColor(kAppPrimaryColor),
  cardTheme: CardTheme(color: Colors.grey[200],),
);
