import 'dart:convert';

import 'package:wastend/api/Api.dart';
import 'package:wastend/api/ApiResponse.dart';
import 'package:wastend/models/InventoryItem.dart';

class InventoryApi {
  static Future<List<InventoryItem>> getAllItems() async {
    ApiResponse response = await Api.apiGet('inventory');
    var data = response.data;
    return data
        .map<InventoryItem>((item) => InventoryItem(
            id: int.parse(item['id'].toString()),
            name: item['name'],
            amount: double.parse(item['amount'].toString()),
            unit: item['unit']))
        .toList();
  }

  static Future<ApiResponse> addItem(InventoryItem item) async {
    return Api.apiPost('inventory', {
      'name': item.name,
      'amount': jsonEncode(item.amount),
      'unit': item.unit,
    });
  }

  static Future<ApiResponse> updateItem(InventoryItem item) async {
    return Api.apiPut('inventory/${item.id}', {
      'name': item.name,
      'amount': jsonEncode(item.amount),
      'unit': item.unit,
    });
  }

  static Future<bool> deleteItem(int id) async {
    return (await Api.apiDelete('inventory/$id')).success;
  }
}
