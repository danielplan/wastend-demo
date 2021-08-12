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
  static const Color red = Color(0xFFFF6161);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
  
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: secondaryColor,
        backgroundColor: light,
        bottomAppBarColor: white,
        buttonColor: primaryColor,
        splashColor: primaryColor,
        primarySwatch: createMaterialColor(primaryColor),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: white,
          splashColor: secondaryColor,
        ),
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
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => white),
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
            headline2: TextStyle(
                color: dark, fontSize: 28.0, fontWeight: FontWeight.bold),
            headline3: TextStyle(
                color: dark, fontSize: 24.0, fontWeight: FontWeight.bold),
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
            headline2: lightTheme.textTheme.headline2!.copyWith(color: white),
            headline3: lightTheme.textTheme.headline3!.copyWith(color: white),
            bodyText1: lightTheme.textTheme.bodyText1!.copyWith(color: white),
            bodyText2: lightTheme.textTheme.bodyText2!.copyWith(color: white)),
        iconTheme: IconThemeData(
          color: white,
        ));
  }
}
