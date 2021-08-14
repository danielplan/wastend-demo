import 'package:flutter/material.dart';
import 'package:wastend/abstract/themes.dart';

class Tag extends StatelessWidget {
  final Color color;
  final String text;

  const Tag({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Text(
        this.text.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: CustomTheme.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
