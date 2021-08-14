import 'package:flutter/material.dart';
import 'package:wastend/widgets/layout/InventoryItemList.dart';
import '/widgets/ui/TitleText.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      new TitleText(
          title: 'Inventory',
          text:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In egestas tellus enim magna pretium'),
      SizedBox(height: 40),
      InventoryItemList(),
    ]);
  }
}
