import 'dart:convert';

class InventoryItem {
  int? id;
  String name;
  double amount;
  String unit;
  double? minimumAmount;
  bool toBuy;
  int? categoryId;

  InventoryItem(
      {this.id,
      required this.name,
      required this.amount,
      required this.unit,
      this.categoryId,
      required this.toBuy,
      this.minimumAmount});

  static InventoryItem fromJson(Map<String, dynamic> json) {
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
}
