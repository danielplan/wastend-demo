import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/abstract/themes.dart';

class CustomAppBar extends AppBar {
  final String text;
  final IconData icon;
  Widget title = Row();
  List<Widget> actions = [];

  CustomAppBar({required this.text, required this.icon}) {
    title = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(this.text,
              style: new TextStyle(
                  color: CustomTheme.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold))
        ]);
  }

  double elevation = 5;
  Color foregroundColor = CustomTheme.white;
  bool centerTitle = false;
  IconThemeData iconTheme = IconThemeData(color: CustomTheme.white);
  Color shadowColor = CustomTheme.primaryColor.withOpacity(0.15);
  Color backgroundColor = CustomTheme.primaryColor;
}
