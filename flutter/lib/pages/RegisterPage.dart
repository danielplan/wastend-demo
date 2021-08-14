import 'package:flutter/material.dart';
import 'package:wastend/widgets/form/RegisterForm.dart';
import 'package:wastend/widgets/layout/PageWrapper.dart';
import '/widgets/ui/TitleText.dart';

class RegisterPage extends StatelessWidget {
  final VoidCallback onChange;
  RegisterPage({required this.onChange});

  @override
  Widget build(BuildContext context) {
    return new PageWrapper(
        name: 'Register',
        icon: Icons.login,
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          new TitleText(
              title: 'Register', text: 'Create a new account and get started'),
          SizedBox(height: 25.0),
          new RegisterForm(onChange: onChange),
        ]));
  }
}
