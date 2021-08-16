import 'package:flutter/material.dart';
import 'package:wastend/api/InventoryApi.dart';
import 'package:wastend/models/InventoryItem.dart';
import 'package:wastend/widgets/form/ErrorList.dart';
import 'package:flutter/services.dart';

class InventoryItemForm extends StatefulWidget {
  final InventoryItem? item;

  InventoryItemForm({this.item});

  @override
  _InventoryItemFormState createState() => _InventoryItemFormState();
}

class _InventoryItemFormState extends State<InventoryItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _errors = [];
  String _name = '';
  double _amount = 0;
  double? _minimumAmount;
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
              decoration: new InputDecoration(labelText: 'Name'),
              style: Theme.of(context).textTheme.bodyText1,
              initialValue:
                  this.widget.item != null ? this.widget.item!.name : null,
              onSaved: (value) => _name = value ?? '',
            ),
            SizedBox(height: 10.0),
            TextFormField(
                decoration: new InputDecoration(labelText: 'Amount'),
                style: Theme.of(context).textTheme.bodyText1,
                keyboardType: TextInputType.number,
                initialValue: this.widget.item != null
                    ? this.widget.item!.amount.toString()
                    : null,
                onSaved: (value) => _amount =
                    value == null || value == '' ? -1 : double.parse(value)),
            SizedBox(height: 10.0),
            TextFormField(
                decoration: new InputDecoration(labelText: 'Unit'),
                style: Theme.of(context).textTheme.bodyText1,
                initialValue:
                    this.widget.item != null ? this.widget.item!.unit : null,
                onSaved: (value) => _unit = value ?? ''),
            SizedBox(height: 10.0),
            TextFormField(
                decoration: new InputDecoration(labelText: 'Minimum amount'),
                style: Theme.of(context).textTheme.bodyText1,
                initialValue: this.widget.item != null
                    ? this.widget.item!.minimumAmount.toString()
                    : null,
                keyboardType: TextInputType.number,
                onSaved: (value) => _minimumAmount =
                    value == null || value == '' ? null : double.parse(value)),
            SizedBox(
              height: 20.0,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                InventoryItem item = new InventoryItem(
                    name: _name,
                    amount: _amount,
                    unit: _unit,
                    toBuy: this.widget.item != null ? this.widget.item!.toBuy : false,
                    minimumAmount: _minimumAmount);
                if(this.widget.item == null) {
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
                } else {
                  item.id = this.widget.item!.id;
                  InventoryApi.updateItem(item).then((response) {
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

                }
              },
              child: const Text('Add item'),
            )),
          ],
        ));
  }
}
