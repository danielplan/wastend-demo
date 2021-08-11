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
        buttonColor: primaryColor,
        fixTextFieldOutlineLabel: true,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => primaryColor),
              textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (states) => TextStyle(color: primaryColor, fontSize: 16.0, fontWeight: FontWeight.bold))),
        ),
        inputDecorationTheme: InputDecorationTheme(
            fillColor: white,
            filled: true,
            labelStyle: TextStyle(color: black),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => primaryColor),
                shadowColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => primaryColor),
                elevation:
                    MaterialStateProperty.resolveWith<double>((states) => 1),
                padding: MaterialStateProperty.resolveWith<EdgeInsets>(
                    (states) => EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 30.0)))),
        textTheme: TextTheme(
            headline1: TextStyle(
                color: dark, fontSize: 36.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(color: dark, fontSize: 16.0, height: 1.8),
            bodyText2: TextStyle(color: dark, fontSize: 14.0),
            button: TextStyle(
                color: white, fontSize: 18.0, fontWeight: FontWeight.bold)),
        fontFamily: 'Quicksand',
        iconTheme: IconThemeData(
          color: dark,
        ));
  }

  static ThemeData get darkTheme {
    return lightTheme.copyWith(
        backgroundColor: black,
        bottomAppBarColor: dark,
        inputDecorationTheme: lightTheme.inputDecorationTheme
            .copyWith(fillColor: dark, labelStyle: TextStyle(color: white)),
        textTheme: lightTheme.textTheme.copyWith(
            headline1: lightTheme.textTheme.headline1!.copyWith(color: white),
            bodyText1: lightTheme.textTheme.bodyText1!.copyWith(color: white),
            bodyText2: lightTheme.textTheme.bodyText2!.copyWith(color: white)),
        iconTheme: IconThemeData(
          color: white,
        ));
  }
}
