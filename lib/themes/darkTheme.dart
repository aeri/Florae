import 'package:flutter/material.dart';

ThemeData buildDarkThemeData() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.tealAccent,
    fontFamily: "NotoSans",
    colorScheme: const ColorScheme.dark(
        surfaceTint: Colors.transparent,
        primary: Colors.white70,
        //onPrimary: Colors.white,
        secondary: Colors.tealAccent),
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Colors.white70,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            fontFamily: "NotoSans"),
        titleLarge: TextStyle(
          color: Colors.white70,
        ),
        titleMedium: TextStyle(
          color: Colors.white70,
        )),
    listTileTheme: const ListTileThemeData(
        iconColor: Colors.white70,
        subtitleTextStyle: TextStyle(color: Colors.white70)),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor:
              WidgetStateProperty.resolveWith((state) => Colors.white70)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: Colors.tealAccent,
      unselectedItemColor: Colors.white30,
      elevation: 10,
      showUnselectedLabels: true,
    ),
    checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? Colors.tealAccent
                : Colors.transparent),
        checkColor: WidgetStateProperty.all(Colors.black),
        side: const BorderSide(width: 2.0, color: Colors.white30)),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.white60),
      iconColor: WidgetStateColor.resolveWith((states) =>
          states.contains(WidgetState.focused)
              ? Colors.tealAccent
              : Colors.white60),
      fillColor: Colors.tealAccent,
      focusColor: Colors.tealAccent,
      hoverColor: Colors.tealAccent,
      helperStyle: const TextStyle(color: Colors.white60),
      hintStyle: const TextStyle(
          decorationColor: Colors.tealAccent, color: Colors.tealAccent),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70)),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal)),
    ),
  );
}
