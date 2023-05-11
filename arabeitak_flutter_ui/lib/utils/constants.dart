import 'package:arabeitak_flutter_ui/utils/utils.dart';
import 'package:flutter/material.dart';

Color kAppPrimaryColor = Color.fromARGB(255, 54, 237, 219);

ThemeData kDarkThemeData = ThemeData.dark().copyWith(
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white70,
  ),
  primaryColor: kAppPrimaryColor,
  colorScheme: ColorScheme.fromSwatch(
      primarySwatch: createMaterialColor(kAppPrimaryColor)),
);
