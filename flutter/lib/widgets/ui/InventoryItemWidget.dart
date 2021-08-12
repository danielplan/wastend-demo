import 'package:flutter/material.dart';
import 'package:wastend/abstract/themes.dart';
import 'package:wastend/api/InventoryApi.dart';
import 'package:wastend/models/InventoryItem.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wastend/widgets/form/ErrorList.dart';

class InventoryItemWidget extends StatefulWidget {
  final InventoryItem item;
  final void Function() onDelete;
  const InventoryItemWidget({required this.item, required this.onDelete});

  @override
  _InventoryItemWidgetState createState() =>
      _InventoryItemWidgetState(item: item, onDelete: onDelete);
}

class _InventoryItemWidgetState extends State<InventoryItemWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  InventoryItem item;
  List<String> _errors = [];
  final void Function() onDelete;

  _InventoryItemWidgetState({required this.item, required this.onDelete});

  void _quickEdit(BuildContext context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: 'close',
      barrierColor: CustomTheme.black.withOpacity(0.75),
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 400,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Edit ${item.name}',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 10),
                    ErrorList(errors: _errors),
                    Material(
                      child: Form(
                          key: _formKey,
                          child: TextFormField(
                              decoration:
                                  new InputDecoration(labelText: 'Amount'),
                              style: Theme.of(context).textTheme.bodyText1,
                              keyboardType: TextInputType.number,
                              initialValue: item.amount.toString(),
                              onSaved: (value) => item.amount =
                                  value == null || value == ''
                                      ? 0
                                      : double.parse(value))),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          InventoryApi.updateItem(item).then((response) {
                            if (response.success) {
                              Navigator.of(context).pop();
                              setState(() {
                                item.amount = item.amount;
                              });
                            } else if (response.errors != null) {
                              setState(() {
                                _errors = response.errors!;
                              });
                            }
                          });
                        },
                        child: Text('Update amount')),
                    SizedBox(height: 10),
                    ElevatedButton(
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style!
                            .copyWith(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => CustomTheme.red)),
                        onPressed: () {
                          _formKey.currentState!.save();
                          InventoryApi.deleteItem(item.id ?? 0).then((success) {
                            this.onDelete();
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text('Delete item'))
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 0.75), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _quickEdit(context),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  new BoxShadow(
                      offset: new Offset(0, 5.0),
                      color: CustomTheme.black.withOpacity(0.05),
                      blurRadius: 25)
                ],
                color: Theme.of(context).bottomAppBarColor),
            child: Stack(alignment: Alignment.bottomLeft, children: [
              Container(
                transform: Matrix4.translationValues(-10, 10, 0),
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: CustomTheme.primaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.edit,
                  color: CustomTheme.white,
                ),
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            intl.NumberFormat("##.##").format(item.amount),
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 2),
                          Text(
                            item.unit.toUpperCase(),
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      )),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            item.name,
                            textAlign: TextAlign.center,
                            style: item.name.length > 5
                                ? Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontSize: 20)
                                : Theme.of(context).textTheme.headline3,
                          )))
                ],
              ),
            ])));
  }
}
