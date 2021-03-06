import 'package:flutter/material.dart';
import 'package:wastend/widgets/form/InventoryItemForm.dart';
import 'package:wastend/widgets/layout/PageWrapper.dart';
import 'package:wastend/widgets/ui/TitleText.dart';

class CreateInventoryItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        name: 'Inventory',
        icon: Icons.house,
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TitleText(
            title: 'Add a new item',
          ),
          SizedBox(height: 25.0),
          InventoryItemForm()
        ]));
  }
}
