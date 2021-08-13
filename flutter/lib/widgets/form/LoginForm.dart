import 'package:flutter/material.dart';
import 'package:wastend/api/AuthApi.dart';
import 'package:wastend/widgets/form/ErrorList.dart';

class LoginForm extends StatefulWidget {
  final void Function() onLogin;

  LoginForm({required this.onLogin});

  @override
  _LoginFormState createState() => _LoginFormState(onLogin: onLogin);
}

class _LoginFormState extends State<LoginForm> {
  final void Function() onLogin;

  _LoginFormState({required this.onLogin});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _errors = [];
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scrollbar(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ErrorList(errors: _errors),
            TextFormField(
              decoration: new InputDecoration(labelText: 'username'),
              style: Theme.of(context).textTheme.bodyText1,
              onSaved: (value) {
                _username = value ?? '';
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: new InputDecoration(labelText: 'password'),
              obscureText: true,
              style: Theme.of(context).textTheme.bodyText1,
              onSaved: (value) {
                _password = value ?? '';
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                AuthApi.login(_username, _password).then((response) {
                  if (!response.success) {
                    setState(() {
                      _errors = response.errors!;
                    });
                  } else {
                    this.onLogin();
                  }
                });
              },
              child: const Text('Log in'),
            )),
          ],
        )));
  }
}
