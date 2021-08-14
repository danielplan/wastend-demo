import 'package:flutter/material.dart';
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
          children: [
            new TitleText(
                title: 'Get started',
                text:
                    'Create a new group or let yourself be added to an existing one'),
            SizedBox(height: 20.0),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      GroupApi.createGroup().then((response) {
                        this.onChange();
                      });
                    },
                    child: Text('Create a new group'))),
            SizedBox(height: 10.0),
            Text(
              "Give your username to one of your group's members.",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ));
  }
}
