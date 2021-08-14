import 'package:flutter/material.dart';
import 'package:wastend/abstract/themes.dart';
import 'package:wastend/api/InventoryApi.dart';
import 'package:wastend/models/InventoryItem.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wastend/widgets/ui/Tag.dart';

class InventoryItemWidget extends StatefulWidget {
  final InventoryItem item;
  final void Function() onDelete;
  final Key key;

  const InventoryItemWidget(
      {required this.item, required this.onDelete, required this.key});

  @override
  _InventoryItemWidgetState createState() =>
      _InventoryItemWidgetState(item: item, onDelete: onDelete);
}

class _InventoryItemWidgetState extends State<InventoryItemWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  InventoryItem item;
  final void Function() onDelete;

  _InventoryItemWidgetState({required this.item, required this.onDelete});

  void _quickEdit(BuildContext context) {
    Key key = UniqueKey();
    showGeneralDialog(
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            primary: false,
            body: Align(
              alignment: Alignment.bottomCenter,
              key: key,
              child: GestureDetector(
                onTap: () {},
                child: PreferredSize(
                  preferredSize: Size.fromHeight(400),
                  child: Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              item.name,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            SizedBox(height: 20),
                            Material(
                              child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                      decoration: new InputDecoration(
                                          labelText: 'Amount',
                                          suffixText: this.item.unit),
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
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
                                  double oldAmount = item.amount;
                                  _formKey.currentState!.save();
                                  InventoryApi.updateItem(item)
                                      .then((response) {
                                    if (response.errors != null) {
                                      final snackBar = SnackBar(
                                        content:
                                            Text(response.errors!.join((', '))),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                    if (response.success) {
                                      Navigator.of(context).pop();
                                      setState(() {});
                                    } else {
                                      setState(() {
                                        item.amount = oldAmount;
                                      });
                                    }
                                  });
                                },
                                child: Text('Update amount')),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            ElevatedButton.icon(
                                onPressed: () {
                                  item.toBuy = !item.toBuy;
                                  InventoryApi.updateItem(item)
                                      .then((response) {
                                    setState(() {});
                                    final snackBar = SnackBar(
                                      content: Text(item.toBuy
                                          ? 'Marked ${item.name} as "to buy"'
                                          : 'Unmarked ${item.name} as "to buy"'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    Navigator.of(context).pop();
                                  });
                                },
                                label: Text(item.toBuy
                                    ? 'Unmark as "to buy"'
                                    : 'Mark as "to buy"'),
                                icon: new Icon(Icons.sell)),
                            SizedBox(height: 10),
                            ElevatedButton.icon(
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) => CustomTheme.red)),
                                onPressed: () {
                                  InventoryApi.deleteItem(item.id ?? 0)
                                      .then((success) {
                                    this.onDelete();
                                    final snackBar = SnackBar(
                                      content: Text('Deleted ${item.name}'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    Navigator.of(context).pop();
                                  });
                                },
                                label: const Text('Delete'),
                                icon: new Icon(Icons.delete))
                          ],
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                  ),
                ),
              ),
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

  Widget _getTag() {
    Map<String, dynamic>? status = item.getStatus();
    if (status == null) {
      return SizedBox(height: 0, width: 0);
    }
    return Container(
        transform: Matrix4.translationValues(0, -10, 0),
        child: Tag(color: status['color'], text: status['text']));
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
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                _getTag(),
                Stack(alignment: Alignment.bottomLeft, children: [
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
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
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
                ])
              ],
            )));
  }
}
