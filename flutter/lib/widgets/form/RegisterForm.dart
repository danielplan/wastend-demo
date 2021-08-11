import 'package:flutter/material.dart';
import 'package:wastend/api/Auth.dart';
import 'package:wastend/widgets/form/ErrorList.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username = '';
  String _displayName = '';
  String _password = '';
  String _password2 = '';
  List<String> _errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scrollbar(
            child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
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
              decoration: new InputDecoration(labelText: 'display name'),
              style: Theme.of(context).textTheme.bodyText1,
              onSaved: (value) {
                _displayName = value ?? '';
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
            SizedBox(height: 10.0),
            TextFormField(
              decoration: new InputDecoration(labelText: 'repeat password'),
              obscureText: true,
              style: Theme.of(context).textTheme.bodyText1,
              onSaved: (value) {
                _password2 = value ?? '';
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                if (_password == _password2) {
                  Auth.register(_username, _displayName, _password)
                      .then((errors) {
                    if (errors == null) {
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        _errors = errors;
                      });
                    }
                  });
                }
              },
              child: const Text('Create account'),
            )),
          ],
        )));
  }
}
