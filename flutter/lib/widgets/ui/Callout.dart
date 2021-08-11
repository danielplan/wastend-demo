import 'package:flutter/material.dart';
import 'package:wastend/abstract/themes.dart';

class Callout extends StatelessWidget {
  final String calloutText;

  Callout({required this.calloutText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      margin: EdgeInsets.only(bottom: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: CustomTheme.secondaryColor,
      ),
      child: Text(this.calloutText, style: TextStyle(
        color: CustomTheme.white,
        fontSize: 16.0
      ),),
    );
  }
}
