import 'package:flutter/material.dart';
import 'package:wastend/api/GroupApi.dart';
import 'package:wastend/widgets/form/ErrorList.dart';

class AddMemberForm extends StatefulWidget {
  const AddMemberForm({Key? key}) : super(key: key);

  @override
  _AddMemberFormState createState() => _AddMemberFormState();
}

class _AddMemberFormState extends State<AddMemberForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username = '';
  List<String> _errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ErrorList(errors: _errors),
              TextFormField(
                decoration: new InputDecoration(labelText: 'Username'),
                style: Theme.of(context).textTheme.bodyText1,
                onSaved: (value) => _username = value ?? '',
              ),
              SizedBox(height: 10.0),
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  GroupApi.addMember(_username).then((response) {
                    print(response.success);
                    print(response.failed);
                    if (response.success) {
                      Navigator.of(context).pop();
                    } else if (response.errors != null) {
                      setState(() {
                        _errors = response.errors!;
                      });
                    }
                  });
                },
                child: const Text('Add user'),
              )),
            ]));
  }
}
