import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static const Color primaryColor = Color(0xFF51E3AF);
  static const Color secondaryColor = Color(0xFF59D0A5);
  static const Color light = Color(0xFFF0FFFE);
  static const Color white = Color(0xFFF9FFFE);
  static const Color dark = Color(0xFF1A211F);
  static const Color black = Color(0xFF111514);

  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: secondaryColor,
        backgroundColor: light,
        bottomAppBarColor: white,
        textTheme: TextTheme(
            headline1: TextStyle(
                color: dark, fontSize: 36.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(color: dark, fontSize: 16.0, height: 1.8),
            bodyText2: TextStyle(color: dark, fontSize: 14.0)),
        fontFamily: 'Quicksand',
        iconTheme: IconThemeData(
          color: dark,
        ));
  }

  static ThemeData get darkTheme {
    return lightTheme.copyWith(
        backgroundColor: black,
        bottomAppBarColor: dark,
        textTheme: lightTheme.textTheme.copyWith(
            headline1: lightTheme.textTheme.headline1!.copyWith(color: white),
            bodyText1: lightTheme.textTheme.bodyText1!.copyWith(color: white),
            bodyText2: lightTheme.textTheme.bodyText2!.copyWith(color: white)),
        iconTheme: IconThemeData(
          color: white,
        ));
  }
}
