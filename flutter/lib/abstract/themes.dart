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

  static const Color primaryColor = Color(0xFF45E3E3);
  static const Color secondaryColor = Color(0xFF49CACA);
  static const Color light = Color(0xFFECF6F6);
  static const Color white = Color(0xFFF8FFFF);
  static const Color dark = Color(0xFF192020);
  static const Color black = Color(0xFF121616);
  static const Color red = Color(0xFFFF6161);
  static const Color green = Color(0xFF61E896);
  static const Color purple = Color(0xFF7B61FF);

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
        snackBarTheme: SnackBarThemeData(
            backgroundColor: primaryColor,
            contentTextStyle: new TextStyle(color: white, fontSize: 16)),
        popupMenuTheme: PopupMenuThemeData(
          color: light,
          elevation: 3,
          textStyle: TextStyle(color: dark, fontSize: 16.0),
        ),
        toggleableActiveColor: primaryColor,
        primaryColorDark: secondaryColor,
        backgroundColor: white,
        bottomAppBarColor: white,
        buttonColor: primaryColor,
        splashColor: primaryColor,
        primarySwatch: createMaterialColor(primaryColor),
        appBarTheme: AppBarTheme(
          foregroundColor: dark,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: white,
          splashColor: secondaryColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) => primaryColor),
              textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (states) => TextStyle(
                      color: primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold))),
        ),
        inputDecorationTheme: InputDecorationTheme(
            fillColor: light,
            suffixStyle: TextStyle(color: dark),
            filled: true,
            labelStyle: const TextStyle(color: dark),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 17.5, horizontal: 25.0)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) => white),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => primaryColor),
                elevation:
                    MaterialStateProperty.resolveWith<double>((states) => 0),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                padding: MaterialStateProperty.resolveWith<EdgeInsets>((states) =>
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0)))),
        textTheme: TextTheme(
            headline1: TextStyle(
                color: dark, fontSize: 36.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(
                color: dark, fontSize: 28.0, fontWeight: FontWeight.bold),
            headline3: TextStyle(
                color: dark, fontSize: 22.0, fontWeight: FontWeight.bold),
            headline4: TextStyle(
                color: dark, fontSize: 18.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(color: dark, fontSize: 16.0, height: 1.8),
            bodyText2: TextStyle(color: dark, fontSize: 14.0),
            button: TextStyle(
                color: white, fontSize: 18.0, fontWeight: FontWeight.bold)),
        fontFamily: 'Montserrat',
        iconTheme: IconThemeData(
          color: dark,
        ));
  }

  static ThemeData get darkTheme {
    return lightTheme.copyWith(
        backgroundColor: black,
        bottomAppBarColor: dark,
        appBarTheme: lightTheme.appBarTheme.copyWith(foregroundColor: white),
        inputDecorationTheme: lightTheme.inputDecorationTheme.copyWith(
            fillColor: dark,
            labelStyle: TextStyle(color: white),
            suffixStyle: TextStyle(color: white)),
        textTheme: lightTheme.textTheme.copyWith(
            headline1: lightTheme.textTheme.headline1!.copyWith(color: white),
            headline2: lightTheme.textTheme.headline2!.copyWith(color: white),
            headline3: lightTheme.textTheme.headline3!.copyWith(color: white),
            headline4: lightTheme.textTheme.headline3!.copyWith(color: white),
            bodyText1: lightTheme.textTheme.bodyText1!.copyWith(color: white),
            bodyText2: lightTheme.textTheme.bodyText2!.copyWith(color: white)),
        iconTheme: IconThemeData(
          color: white,
        ));
  }
}
