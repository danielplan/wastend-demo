import 'package:flutter/material.dart';
import 'package:wastend/widgets/layout/UserList.dart';
import '/widgets/ui/TitleText.dart';

class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TitleText(
          title: 'Group',
          text:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In egestas tellus enim magna pretium'),
      SizedBox(height: 20),
      UserList(),
    ]);
  }
}
