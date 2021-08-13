import 'package:flutter/material.dart';
import 'package:wastend/pages/RegisterPage.dart';
import 'package:wastend/widgets/form/LoginForm.dart';
import 'package:wastend/widgets/layout/PageWrapper.dart';
import '/widgets/ui/TitleText.dart';

class LoginPage extends StatelessWidget {
  final void Function() onLogin;

  LoginPage({required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return new PageWrapper(
        name: 'Login',
        icon: Icons.login,
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          new TitleText(title: 'Login', text: 'Get started now'),
          SizedBox(height: 25.0),
          new LoginForm(onLogin: onLogin),
          new TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text('Or create a new account'))
        ]));
  }
}
