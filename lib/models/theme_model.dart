import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/global_styles.dart';

// TODO: Add option in settigs to allow user to select a color
// in the custom options, and save it to the shared preferences.

enum ColorSeed {
  noColor('No Color', Colors.transparent),
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Color(0xFFEC6995)),
  brightBlue('Bright Blue', Color(0xFF0000FF)),
  brightGreen('Bright Green', Color(0xFF00FF00)),
  brightRed('Bright Red', Color(0xFFFF0000)),
  ;

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

// Define the light theme
final lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(
    color: StyleGlobalVariables.primaryColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: StyleGlobalVariables.primaryColor,
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(
      color: Color(0xffB0B0B0),
    ),
    hintStyle: const TextStyle(
      color: Color(0xffB0B0B0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: StyleGlobalVariables.primaryTextfieldInputBorderColor,
      ), // Default border color
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: StyleGlobalVariables.primaryTextfieldInputBorderColor,
      ), // Color when focused
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: StyleGlobalVariables.primaryTextfieldInputBorderColor,
      ), // Color when enabled
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
          color: StyleGlobalVariables.primaryErrorColor), // Color for errors
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: StyleGlobalVariables.accentErrorColor,
      ), // Color for focused error
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: StyleGlobalVariables.primaryColor,
    selectedLabelStyle: TextStyle(
      color: StyleGlobalVariables.primaryColor,
    ),
    selectedIconTheme: IconThemeData(
      color: StyleGlobalVariables.primaryColor,
    ),
  ),
);

// Define the dark theme
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
);

// Define a custom theme
ThemeData customTheme(Color seedColor) => ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.lightGreen[100],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
