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
  String filter = 'az';
  static Map<String, String> filterItems = {
    'az': 'Alphabetically A-Z',
    'za': 'Alphabetically Z-A',
    'buy': 'To buy',
  };

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

  List<InventoryItem>? _sortItems(List<InventoryItem>? items) {
    if (items == null) {
      return [];
    }
    switch (filter) {
      case 'buy':
        items.sort((a, b) => (a.toBuy ? 1 : 0) + (b.toBuy ? 1 : 0));
        return items;
      case 'az':
        items.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        return items;
      case 'za':
        items.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        return items.reversed.toList();
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      DropdownButton<String>(
          value: filter,
          dropdownColor: Theme.of(context).backgroundColor,
          style: Theme.of(context).textTheme.bodyText1!,
          itemHeight: 70,
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          onChanged: (String? newValue) {
            setState(() {
              filter = newValue!;
            });
          },
          items: filterItems.keys
              .map((key) => new DropdownMenuItem<String>(
                    child: Text(filterItems[key] ?? ''),
                    value: key,
                  ))
              .toList()),
      SizedBox(height: 40),
      (_items == null
          ? Loading()
          : (_items != null && _items!.length > 0
              ? Column(
                  children: _sortItems(_filteredItems)!
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
