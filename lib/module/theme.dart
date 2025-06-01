import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'assets.dart'; // Make sure this defines amber, blk, ltWhite, white, mainColor, brown, etc.

class ThemeProvider extends ChangeNotifier {
  late SharedPreferences prefs;
  late ThemeData selectedTheme;

  final ThemeData dark = ThemeData.dark().copyWith(
    sliderTheme: SliderThemeData(
      activeTrackColor: amber,
      inactiveTrackColor: amber.withOpacity(0.3),
      thumbColor: amber,
      overlayColor: amber.withAlpha(32),
    ),
    unselectedWidgetColor: white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ltWhite,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ltWhite,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) return amber;
        return white;
      }),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontFamily: "lpmq",
        fontWeight: FontWeight.w500,
        fontSize: 23,
        color: white,
      ),
      titleSmall: TextStyle(
        fontSize: 19,
        fontFamily: 'lpmq',
        color: white,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(color: brown),
      labelColor: white,
    ),
    primaryColor: const Color(0xFF282828),
    primaryColorDark: const Color(0xFF282828),
    scaffoldBackgroundColor: brown,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 63, 63, 63),
      secondary: Color(0xFF424242),
    ).copyWith(background: const Color(0xFFE7E7E7)),
  );

  final ThemeData light = ThemeData.light().copyWith(
    sliderTheme: SliderThemeData(
      activeTrackColor: amber,
      inactiveTrackColor: amber.withOpacity(0.3),
      thumbColor: amber,
      overlayColor: amber.withAlpha(32),
    ),
    unselectedWidgetColor: white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) return amber;
        return white;
      }),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: mainColor,
        fontFamily: "lpmq",
        fontWeight: FontWeight.w500,
        fontSize: 23,
      ),
      titleSmall: TextStyle(
        fontSize: 19,
        fontFamily: 'lpmq',
        color: white,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(color: mainColor),
      labelColor: white,
    ),
    primaryColor: const Color(0xff074425),
    primaryColorDark: const Color(0xff074425),
    brightness: Brightness.light,
    hintColor: const Color.fromARGB(255, 254, 254, 254),
    scaffoldBackgroundColor: const Color(0xFFE7E7E7),
    colorScheme: const ColorScheme.light(
      primary: Color(0xff096637),
      secondary: Color(0xff074425),
    ),
  );

  ThemeProvider(bool darkThemeOn) {
    selectedTheme = darkThemeOn ? dark : light;
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> swapTheme() async {
    prefs = await SharedPreferences.getInstance();
    if (selectedTheme == dark) {
      selectedTheme = light;
      await prefs.setBool("darkTheme", false);
    } else {
      selectedTheme = dark;
      await prefs.setBool("darkTheme", true);
    }
    notifyListeners();
  }

  ThemeData getTheme() => selectedTheme;
}
