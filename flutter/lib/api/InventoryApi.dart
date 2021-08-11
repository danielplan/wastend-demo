import 'package:wastend/api/Api.dart';
import 'package:wastend/api/ApiResponse.dart';

class InventoryApi {
  static Future<ApiResponse> getAllItems() async {
    return Api.apiGet('inventory');
  }

  static Future<ApiResponse> addItem({
    required String name,
    required double amount,
    required String unit,
    required int categoryId,
  }) async {
    return Api.apiPost('inventory', {
      'name': name,
      'amount': amount,
      'unit': unit,
      'category': categoryId,
    });
  }
}
