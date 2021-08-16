import 'package:flutter/material.dart';
import 'package:wastend/api/GroupApi.dart';
import 'package:wastend/widgets/layout/UserList.dart';
import '/widgets/ui/TitleText.dart';

class GroupPage extends StatelessWidget {
  final VoidCallback onLeave;

  GroupPage({required this.onLeave});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TitleText(
          title: 'Group',
          text:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In egestas tellus enim magna pretium'),
      SizedBox(height: 20),
      UserList(),
      SizedBox(height: 20),
      ElevatedButton(
        child: const Text('Leave this group'),
        onPressed: () {
          GroupApi.leaveGroup().then((success) {
            this.onLeave();
          });
        },
      )
    ]);
  }
}
