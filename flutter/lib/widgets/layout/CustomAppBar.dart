import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastend/api/AuthApi.dart';
import '/abstract/themes.dart';

class CustomAppBar extends AppBar {
  final String text;
  final IconData icon;
  Widget title = Row();

  CustomAppBar({required this.text, required this.icon}) {
    title = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(this.icon, size: 28.0, color: CustomTheme.white),
          SizedBox(width: 7),
          Text(this.text,
              style: new TextStyle(
                  color: CustomTheme.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold))
        ]);
  }

  double elevation = 5;
  Color foregroundColor = CustomTheme.white;
  bool centerTitle = true;
  IconThemeData iconTheme = IconThemeData(color: CustomTheme.white);
  Color shadowColor = CustomTheme.secondaryColor.withOpacity(0.15);
  Color backgroundColor = CustomTheme.secondaryColor;
  List<Widget> actions = [
    IconButton(
      onPressed: () {
        currentTheme.toggleTheme();
      },
      icon: Icon(Icons.light_mode, size: 32.0, color: CustomTheme.light),
    ),
    IconButton(
      onPressed: () {
        AuthApi.logout();
      },
      icon: Icon(Icons.logout, size: 32.0, color: CustomTheme.light),
    )
  ];
}
