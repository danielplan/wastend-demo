import 'package:flutter/material.dart';
import 'package:wastend/api/GroupApi.dart';
import 'package:wastend/widgets/layout/UserList.dart';
import '/widgets/ui/TitleText.dart';

class GroupPage extends StatelessWidget {
  final VoidCallback onLeave;

  GroupPage({required this.onLeave});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TitleText(title: 'Group'),
      SizedBox(height: 30),
      UserList(),
      SizedBox(height: 40),
      ElevatedButton(
        child: const Text('Leave'),
        onPressed: () {
          GroupApi.leaveGroup().then((success) {
            this.onLeave();
          });
        },
      )
    ]);
  }
}
