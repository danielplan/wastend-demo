import 'package:flutter/material.dart';
import 'package:wastend/api/InventoryApi.dart';
import 'package:wastend/models/InventoryItem.dart';
import 'package:wastend/widgets/form/ErrorList.dart';
import 'package:flutter/services.dart';
import 'package:select_form_field/select_form_field.dart';

class InventoryItemForm extends StatefulWidget {

  @override
  _InventoryItemFormState createState() => _InventoryItemFormState();
}

class _InventoryItemFormState extends State<InventoryItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> units = [
    {
      'value': 'kg',
      'label': 'Kilograms (kg)',
    },
    {
      'value': 'l',
      'label': 'Liters (l)',
    }
  ];
  List<String> _errors = [];
  String _name = '';
  double _amount = 0;
  String _unit = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ErrorList(errors: _errors),
            TextFormField(
              decoration: new InputDecoration(labelText: 'name of the item'),
              style: Theme.of(context).textTheme.bodyText1,
              onSaved: (value) => _name = value ?? '',
            ),
            SizedBox(height: 10.0),
            TextFormField(
                decoration: new InputDecoration(labelText: 'Amount'),
                style: Theme.of(context).textTheme.bodyText1,
                keyboardType: TextInputType.number,
                onSaved: (value) => _amount =
                    value == null || value == '' ? 0 : double.parse(value)),
            SizedBox(height: 10.0),
            SelectFormField(
                initialValue: 'kg',
                labelText: 'Unit',
                items: units,
                style: Theme.of(context).textTheme.bodyText1,
                onSaved: (value) => _unit = value),
            SizedBox(
              height: 20.0,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                InventoryItem item = new InventoryItem(
                    name: _name, amount: _amount, unit: _unit);
                InventoryApi.addItem(item).then((response) {
                  if (response.success) {
                    Navigator.of(context).pop(item);
                  } else {
                    setState(() {
                      if (response.errors != null) {
                        _errors = response.errors!;
                      }
                    });
                  }
                });
              },
              child: const Text('Add item'),
            )),
          ],
        ));
  }
}
