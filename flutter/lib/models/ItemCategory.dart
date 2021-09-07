import 'package:flutter/material.dart';

class ItemCategory {
  int? id;
  String name;

  ItemCategory({required this.name, this.id});

  static ItemCategory fromJson(Map<String, dynamic> json) {
    return new ItemCategory(
      id: int.parse(json['id'].toString()),
      name: json['name'],
    );
  }

  static IconData getIcon(id) {
    switch (id) {
      case 1:
        return Icons.kitchen;
      case 2:
        return Icons.bathroom;
      case 3:
        return Icons.sports_baseball;
    }
    return Icons.category;
  }
}
