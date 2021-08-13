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

  @override
  void initState() {
    super.initState();
    if (_items == null) {
      InventoryApi.getAllItems()
          .then((items) => setState(() => _items = items));
    }
  }

  Future<void> getInventoryItems() async {}

  @override
  Widget build(BuildContext context) {
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
                            key: new UniqueKey(),
                            item: item,
                            onDelete: () =>
                                setState(() => _items!.remove(item))))
                        .toList())
              ])
            : Text('No items found'));
  }
}
