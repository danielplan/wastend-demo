import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final String text;

  TitleText({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(this.title, style: Theme.of(context).textTheme.headline1),
      SizedBox(height: 5.0),
      Text(this.text, style: Theme.of(context).textTheme.bodyText1)
    ]);
  }
}
