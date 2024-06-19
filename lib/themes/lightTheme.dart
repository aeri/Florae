import 'package:flutter/material.dart';

ThemeData buildLightThemeData() {
  return ThemeData(
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.grey[100],
    fontFamily: "NotoSans",
    colorScheme: const ColorScheme.light(
        surfaceTint: Colors.transparent,
        primary: Colors.black54,
        secondary: Colors.teal),
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Colors.black54,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            fontFamily: "NotoSans"),
        titleLarge: TextStyle(
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          color: Colors.black54,
        )),
    listTileTheme: const ListTileThemeData(
        iconColor: Colors.black54,
        subtitleTextStyle: TextStyle(color: Colors.black54)),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor:
              WidgetStateProperty.resolveWith((state) => Colors.black)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.teal,
      elevation: 10,
      showUnselectedLabels: true,
    ),
    checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? Colors.teal
                : Colors.transparent),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: const BorderSide(width: 2.0, color: Colors.black54)),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.black),
      iconColor: WidgetStateColor.resolveWith((states) =>
          states.contains(WidgetState.focused) ? Colors.teal : Colors.black54),
      fillColor: Colors.teal,
      focusColor: Colors.teal,
      hoverColor: Colors.teal,
      hintStyle:
          const TextStyle(decorationColor: Colors.teal, color: Colors.teal),
      helperStyle: const TextStyle(color: Colors.black54),
      enabledBorder: const UnderlineInputBorder(),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal)),
    ),
  );
}
