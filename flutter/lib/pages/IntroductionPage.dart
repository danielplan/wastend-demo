import 'package:flutter/material.dart';
import 'package:wastend/api/AuthApi.dart';
import 'package:wastend/api/GroupApi.dart';
import 'package:wastend/widgets/layout/PageWrapper.dart';
import 'package:wastend/widgets/ui/TitleText.dart';

class IntroductionPage extends StatelessWidget {
  final void Function() onChange;

  IntroductionPage({required this.onChange});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        name: 'Get started',
        icon: Icons.home,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            new TitleText(
                title: 'Get started',
                text:
                    "To get started either create a new group or ask one of your group's members to add you to the group"),
            SizedBox(height: 35.0),
            ElevatedButton(
                onPressed: () {
                  GroupApi.createGroup().then((response) {
                    this.onChange();
                  });
                },
                child: Text('Create a new group')),
            SizedBox(height: 15.0),
            TextButton(
                onPressed: () {
                  AuthApi.logout().then((value) => this.onChange());
                },
                child: Text('Logout'))
          ],
        ));
  }
}
