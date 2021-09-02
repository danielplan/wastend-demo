import 'package:flutter/material.dart';
import 'package:wastend/abstract/themes.dart';
import 'package:wastend/models/User.dart';

class UserWidget extends StatelessWidget {
  final User user;

  UserWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).inputDecorationTheme.fillColor),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: CustomTheme.dark,
                borderRadius: BorderRadius.circular(30)),
            child: Icon(
              Icons.person,
              color: CustomTheme.white,
              size: 32,
            )),
        SizedBox(width: 15),
        Flexible(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              user.displayName,
              style: Theme.of(context).textTheme.headline4,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 3),
            Text(
              '@${user.username}',
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.ellipsis,
            ),
          ]),
        )
      ]),
    );
  }
}
