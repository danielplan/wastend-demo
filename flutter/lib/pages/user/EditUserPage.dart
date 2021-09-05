import 'package:flutter/material.dart';
import 'package:wastend/models/User.dart';
import 'package:wastend/widgets/form/RegisterForm.dart';
import 'package:wastend/widgets/layout/PageWrapper.dart';
import 'package:wastend/widgets/ui/TitleText.dart';

class EditUserPage extends StatelessWidget {
  final User user;

  EditUserPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        name: 'Inventory',
        icon: Icons.house,
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TitleText(title: 'Edit your account'),
          SizedBox(height: 25.0),
          RegisterForm(user: user)
        ]));
  }
}
