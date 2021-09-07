import 'package:flutter/material.dart';
import 'package:wastend/abstract/themes.dart';
import 'package:wastend/api/InventoryApi.dart';
import 'package:wastend/models/InventoryItem.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wastend/models/ItemCategory.dart';
import 'package:wastend/pages/inventory/EditInventoryItemPage.dart';

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
                            _getAmountIndicator(true),
                            SizedBox(height: 5),
                            Text(
                              item.name,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            SizedBox(height: 3),
                            _getAmountText(),
                            SizedBox(height: 25),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  child: Material(
                                    color: Theme.of(context).backgroundColor,
                                    child: Form(
                                        key: _formKey,
                                        child: TextFormField(
                                            decoration: new InputDecoration(
                                                labelText: 'Amount',
                                                suffixText: this.item.unit),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            keyboardType: TextInputType.number,
                                            initialValue:
                                                item.amount.toString(),
                                            onSaved: (value) => item.amount =
                                                value == null || value == ''
                                                    ? 0
                                                    : double.parse(value))),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                    width: 65,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        double oldAmount = item.amount;
                                        _formKey.currentState!.save();
                                        InventoryApi.updateItem(item)
                                            .then((response) {
                                          if (response.errors != null) {
                                            final snackBar = SnackBar(
                                              content: Text(response.errors!
                                                  .join((', '))),
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
                                      child: Icon(Icons.arrow_forward),
                                    )),
                              ],
                            ),
                            SizedBox(height: 20),
                            Divider(
                              thickness: 3,
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                                onPressed: () {
                                  item.toBuy = !item.toBuy;
                                  InventoryApi.updateItem(item)
                                      .then((response) {
                                    if (response.success) {
                                      setState(() {});
                                      final snackBar = SnackBar(
                                        content: Text(item.toBuy
                                            ? 'Marked ${item.name} as "to buy"'
                                            : 'Unmarked ${item.name} as "to buy"'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.of(context).pop();
                                    }
                                  });
                                },
                                label: Text(item.toBuy
                                    ? 'Unmark as "to buy"'
                                    : 'Mark as "to buy"'),
                                icon: new Icon(Icons.sell)),
                            SizedBox(height: 10),
                            ElevatedButton.icon(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditInventoryItemPage(item: item))),
                                label: const Text('Edit'),
                                icon: new Icon(Icons.edit)),
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

  Widget _getAmountDot(Color color) {
    return Container(
      width: 11,
      height: 11,
      margin: EdgeInsets.all(2),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
    );
  }

  List<Widget> _getAmountIndicatorList(status) {
    List<Widget> _indicators = [];
    int maxDots = 3;
    for (int i = 0; i < maxDots - status['coloredDots']; i++) {
      _indicators.add(_getAmountDot(Theme.of(this.context)
          .textTheme
          .bodyText1!
          .color!
          .withOpacity(0.15)));
    }
    for (int i = 0; i < status['coloredDots']; i++) {
      _indicators.add(_getAmountDot(status['color']));
    }
    return _indicators;
  }

  Widget _getAmountIndicator(bool reversed) {
    Map<String, dynamic>? status = item.getStatus();
    if (status == null) {
      return SizedBox(height: 0, width: 0);
    }
    return Row(
        children: reversed
            ? _getAmountIndicatorList(status).reversed.toList()
            : _getAmountIndicatorList(status));
  }

  Widget _getCategoryIcon() {
    Map<String, dynamic>? status = item.getStatus();
    return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: status != null ? status['color'] : CustomTheme.dark,
        ),
        child: Icon(
          ItemCategory.getIcon(item.categoryId),
          color: CustomTheme.white,
          size: 36,
        ));
  }

  String formatAmount(double amount) {
    return intl.NumberFormat("##.##").format(amount);
  }

  Widget _getAmountText() {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(
        '${formatAmount(item.amount)}${item.unit}',
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
      ),
      (item.minimumAmount != null
          ? Text(
              ' / ${formatAmount(item.minimumAmount!)}${item.unit}',
              style: TextStyle(fontSize: 12),
            )
          : SizedBox())
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _quickEdit(context),
        onLongPress: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditInventoryItemPage(item: item))),
        child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).inputDecorationTheme.fillColor),
            child: Stack(alignment: Alignment.topLeft, children: [
              item.toBuy
                  ? Container(
                      child: Icon(Icons.sell,
                          color: Theme.of(context).backgroundColor, size: 16),
                      width: 30,
                      height: 30,
                      transform: Matrix4.translationValues(-20, -20, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).textTheme.bodyText1!.color),
                    )
                  : Container(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          _getCategoryIcon(),
                          SizedBox(width: 20),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name,
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                SizedBox(height: 3),
                                _getAmountText(),
                              ])
                        ])),
                    _getAmountIndicator(false),
                  ]),
            ])));
  }
}
