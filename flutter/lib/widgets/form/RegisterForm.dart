import 'package:flutter/material.dart';
import 'package:wastend/api/AuthApi.dart';
import 'package:wastend/models/User.dart';
import 'package:wastend/widgets/form/ErrorList.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback? onChange;
  final User? user;

  RegisterForm({this.onChange, this.user});

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          direction: Axis.vertical,
          children: <Widget>[
            ErrorList(errors: _errors),
            TextFormField(
              decoration: new InputDecoration(labelText: 'Username'),
              style: Theme.of(context).textTheme.bodyText1,
              initialValue:
                  this.widget.user != null ? this.widget.user!.username : null,
              onSaved: (value) {
                _username = value ?? '';
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: new InputDecoration(labelText: 'Display name'),
              style: Theme.of(context).textTheme.bodyText1,
              initialValue: this.widget.user != null
                  ? this.widget.user!.displayName
                  : null,
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
            ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                if (_password == _password2) {
                  if (this.widget.user == null) {
                    AuthApi.register(_username, _displayName, _password)
                        .then((response) {
                      if (response.success && this.widget.onChange != null) {
                        this.widget.onChange!();
                        Navigator.of(context).pop();
                      } else {
                        setState(() {
                          _errors = response.errors!;
                        });
                      }
                    });
                  } else {
                    User _user = new User(
                        username: _username, displayName: _displayName);
                    AuthApi.update(_user, _password).then((response) {
                      if (response.success) {
                        Navigator.of(context).pop();
                      } else {
                        setState(() {
                          _errors = response.errors!;
                        });
                      }
                    });
                  }
                }
              },
              child: Text(
                  this.widget.user == null ? 'Create account' : 'Edit account'),
            ),
          ],
        )));
  }
}
