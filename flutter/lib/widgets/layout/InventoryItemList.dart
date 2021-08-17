import 'package:flutter/material.dart';
import 'package:wastend/abstract/themes.dart';
import 'package:wastend/api/InventoryApi.dart';
import 'package:wastend/models/InventoryItem.dart';
import 'package:wastend/widgets/ui/InventoryItemWidget.dart';
import 'package:wastend/widgets/ui/Loading.dart';

class InventoryItemList extends StatefulWidget {
  const InventoryItemList({Key? key}) : super(key: key);

  @override
  _InventoryItemListState createState() => _InventoryItemListState();
}

class _InventoryItemListState extends State<InventoryItemList> {
  List<InventoryItem>? _items;
  List<InventoryItem>? _filteredItems;

  @override
  void initState() {
    super.initState();
    InventoryApi.getAllItems().then((items) => setState(
          () {
            _items = items;
            _filteredItems = items;
          },
        ));
  }

  Future<void> getInventoryItems() async {}

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 15, color: CustomTheme.dark.withOpacity(0.05))
            ]),
        child: TextFormField(
          decoration: new InputDecoration(
              labelText: 'Search...',
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.bodyText1!.color,
              )),
          style: Theme.of(context).textTheme.bodyText1,
          onChanged: (value) {
            if (value.trim() != '' && _items != null) {
              setState(() {
                _filteredItems = _items!.toList();
                _filteredItems!
                    .removeWhere((element) => element.name.indexOf(value) < 0);
              });
            } else if (_items != null) {
              setState(() {
                _filteredItems = _items!.toList();
              });
            }
          },
        ),
      ),
      SizedBox(height: 40),
      (_items == null
          ? Loading()
          : (_items != null && _items!.length > 0
              ? Column(
                  children: _filteredItems!
                      .map((item) => InventoryItemWidget(
                          key: new UniqueKey(),
                          item: item,
                          onDelete: () => setState(() {
                                _items!.remove(item);
                                _filteredItems!.remove(item);
                              })))
                      .toList())
              : Text('No items found')))
    ]);
  }
}
