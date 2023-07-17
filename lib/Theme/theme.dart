import 'package:flutter/material.dart';
import 'package:my_chats_appss/Theme/colors.dart';

final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 63, 17, 177),
    onPrimary: Color.fromRGBO(67, 195, 255, 1.0),
    onTertiary: Color.fromRGBO(80, 138, 254, 1.0),
    onSecondary: Color.fromRGBO(255, 255, 255, 1),
    onSurface: Color.fromRGBO(255, 140, 10, 1)
);

class LightTheme {
  LightTheme();

  static ThemeData buildTheme() {

    final ThemeData base = ThemeData();
    return base.copyWith(
      colorScheme: colorScheme,
      // appBarTheme:  AppBarTheme().copyWith(
      //     backgroundColor: colorScheme.secondary,
      // ),
    );
  }
}
