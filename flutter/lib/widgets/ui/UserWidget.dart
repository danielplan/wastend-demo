import 'package:flutter/material.dart';
import 'package:wastend/models/User.dart';

class UserWidget extends StatelessWidget {
  final User user;

  UserWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(Icons.person),
      SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(user.displayName, style: Theme.of(context).textTheme.bodyText1),
        Text('@${user.username}', style: Theme.of(context).textTheme.bodyText2)
      ])
    ]);
  }
}
