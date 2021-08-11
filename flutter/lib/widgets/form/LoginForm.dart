import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wastend/api/Auth.dart';
import 'package:wastend/widgets/form/ErrorList.dart';
import 'package:wastend/widgets/ui/Callout.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
                Auth.login(_username, _password).then((errors) {
                  if (errors != null) {
                    setState(() {
                      _errors = errors;
                    });
                  }
                });
              },
              child: const Text('Log in'),
            )),
          ],
        )));
  }
}
