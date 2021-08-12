// @dart=2.9
import 'package:flutter/material.dart';
import 'package:wastend/pages/SplashScreen.dart';
import 'abstract/themes.dart';
void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'wastend',
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        themeMode: currentTheme.currentTheme,
        home: SplashScreen());
  }
}
