import 'package:flutter/material.dart';
import 'package:wastend/api/InventoryApi.dart';
import 'package:wastend/models/InventoryItem.dart';
import 'package:wastend/widgets/ui/InventoryItemWidget.dart';

class InventoryItemList extends StatefulWidget {
  const InventoryItemList({Key? key}) : super(key: key);

  @override
  _InventoryItemListState createState() => _InventoryItemListState();
}

class _InventoryItemListState extends State<InventoryItemList> {
  List<InventoryItem>? _items;

  Future<void> getInventoryItems() async {
    List<InventoryItem> items = await InventoryApi.getAllItems();
    setState(() {
      _items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_items == null) {
      this.getInventoryItems();
    }
    return _items == null
        ? Text('Loading')
        : (_items != null && _items!.length > 0
            ? Column(children: [
                GridView.count(
                    shrinkWrap: true,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                    clipBehavior: Clip.none,
                    primary: false,
                    crossAxisCount: 2,
                    children: _items!
                        .map((item) => InventoryItemWidget(
                            item: item,
                            onDelete: () {
                              setState(() {
                                _items = null;
                              });
                            }))
                        .toList())
              ])
            : Text('No items found'));
  }
}
