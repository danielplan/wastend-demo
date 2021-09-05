import 'dart:convert';

import 'package:wastend/abstract/themes.dart';

class InventoryItem {
  int? id;
  String name;
  double amount;
  String unit;
  double? minimumAmount;
  bool toBuy;
  int? categoryId;

  static Map<ItemStatus, Map<String, dynamic>> status = {
    ItemStatus.LOW: {'color': CustomTheme.red, 'coloredDots': 1},
    ItemStatus.NORMAL: {'color': CustomTheme.green, 'coloredDots': 2},
    ItemStatus.HIGH: {'color': CustomTheme.purple, 'coloredDots': 3},
  };

  InventoryItem(
      {this.id,
      required this.name,
      required this.amount,
      required this.unit,
      this.categoryId,
      required this.toBuy,
      this.minimumAmount});

  static InventoryItem fromJson(Map<String, dynamic> json) {
    print(json);
    return new InventoryItem(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      amount: double.parse(json['amount'].toString()),
      unit: json['unit'],
      toBuy: json['toBuy'] ?? false,
      minimumAmount: json['minimumAmount'] != 'null'
          ? double.parse(json['minimumAmount'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'amount': jsonEncode(this.amount),
      'minimumAmount': jsonEncode(this.minimumAmount),
      'unit': this.unit,
      'toBuy': jsonEncode(this.toBuy)
    };
  }

  Map<String, dynamic>? getStatus() {
    if (this.minimumAmount == null) {
      return null;
    }
    if (this.amount < this.minimumAmount!) {
      return status[ItemStatus.LOW];
    } else if (this.minimumAmount! * 2 < this.amount) {
      return status[ItemStatus.HIGH];
    } else {
      return status[ItemStatus.NORMAL];
    }
  }
}

enum ItemStatus { LOW, NORMAL, HIGH }
