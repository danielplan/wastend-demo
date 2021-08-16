import 'package:flutter/material.dart';
import 'package:wastend/models/InventoryItem.dart';
import 'package:wastend/widgets/form/InventoryItemForm.dart';
import 'package:wastend/widgets/layout/PageWrapper.dart';
import 'package:wastend/widgets/ui/TitleText.dart';

class EditInventoryItemPage extends StatelessWidget {
  final InventoryItem item;

  const EditInventoryItemPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        name: 'Inventory',
        icon: Icons.house,
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TitleText(
              title: 'Add a new item',
              text: 'Create a new item in your inventory'),
          SizedBox(height: 25.0),
          InventoryItemForm(item: item)
        ]));
  }
}
