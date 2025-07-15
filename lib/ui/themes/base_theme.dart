import 'package:flutter/material.dart';

abstract class BaseTheme {
  Color get backgroundColor;
  Color get primaryContent;
  Color get primaryAccent;
  Color get secondaryColor;
  Color get cardColor;
  Brightness get brightness;
  ThemeData get themeData => ThemeData(
    fontFamily: 'Huninn',
    primaryColor: primaryContent,
    cardColor: cardColor,
    textTheme: TextTheme(
      displaySmall: TextStyle(color: backgroundColor, fontSize: 12),
      displayMedium: TextStyle(color: primaryContent, fontSize: 13),
      displayLarge: TextStyle(color: primaryContent, fontSize: 14),
      bodySmall: TextStyle(color: Colors.grey, fontSize: 15, height: 1),
      bodyMedium: TextStyle(color: primaryContent, fontSize: 16),
      bodyLarge: TextStyle(color: primaryContent, fontSize: 17),
      titleSmall: TextStyle(color: secondaryColor, fontSize: 16),
      titleMedium: TextStyle(color: secondaryColor, fontSize: 18),
      titleLarge: TextStyle(color: primaryContent, fontSize: 26),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: secondaryColor),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
      prefixIconColor: secondaryColor,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondaryColor, // Цвет текста и обводки
        side: BorderSide(color: secondaryColor), // Цвет границы
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Закругление 15
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: secondaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        side: BorderSide(color: Colors.transparent), // Цвет границы
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Закругление 15
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shadowColor: Colors.transparent,
      ),
    ),
    cardTheme: CardThemeData(
      color: cardColor,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: cardColor,
      textTheme: ButtonTextTheme.primary,
    ),
    checkboxTheme: CheckboxThemeData(
      // Настройка формы
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      // Стиль для невыбранного состояния (черная обводка)
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(width: 2, color: primaryContent),
      ),
      // Цвет галочки (синий)
      checkColor: WidgetStateProperty.all(secondaryColor),
    ),
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: primaryAccent,
      onPrimary: primaryAccent,
      secondary: secondaryColor,
      onSecondary: secondaryColor,
      error: Colors.black,
      onError: Colors.black,
      surface: backgroundColor,
      onSurface: primaryContent,
    ),
  );
}
