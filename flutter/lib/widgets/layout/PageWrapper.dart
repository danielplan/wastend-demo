import 'package:flutter/material.dart';
import 'package:wastend/widgets/layout/AppWrapper.dart';

class PageWrapper extends StatelessWidget {
  final String name;
  final IconData icon;
  final Widget body;

  PageWrapper({required this.name, required this.icon, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWrapper.getAppbar(context),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
            child: body),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
