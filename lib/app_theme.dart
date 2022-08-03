import 'package:flutter/material.dart';
import 'package:nrk/themes/custom_button_theme.dart';

class AppTheme {
  static const backgroundWhite = Color(0xFFF6F6F6);
  static const blue = Color(0xFF00B9F2);
  static const purple = Color(0xFF260859);
  static const turquoise = Color(0xFF00AAAD);
  static const marine = Color(0xFF004071);
  static const lightBeige = Color(0xFFE4E0d9);
  static const darkBeige = Color(0xFF857D78);
  static const pink = Color(0xFFEC0080);
  static const lightGreen = Color(0xFFA5CD39);
  static const yellow = Color(0xFFFFD41A);

  static ThemeData light = ThemeData(
    colorScheme: const ColorScheme(
      primary: blue,
      secondary: purple,
      surface: Colors.white,
      background: backgroundWhite,
      error: pink,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    elevatedButtonTheme: CustomButtonThemes.elevatedButton,
  );

  static ThemeData dark = ThemeData(
    colorScheme: const ColorScheme(
      primary: purple,
      secondary: blue,
      surface: Colors.black,
      background: Colors.white10,
      error: pink,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: pink,
      brightness: Brightness.dark,
    ),
  );

  static ButtonStyle smallButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return AppTheme.blue.withOpacity(0.1);
      }

      return AppTheme.blue;
    }),
  );
}
