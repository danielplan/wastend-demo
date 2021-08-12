import 'package:flutter/material.dart';
import 'package:wastend/api/InventoryApi.dart';
import 'package:wastend/models/InventoryItem.dart';

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
      getInventoryItems();
    }
    return _items == null
        ? Text('Loading')
        : _items!.length == 0
            ? Text('No items found')
            : Text('items found');
  }
}
