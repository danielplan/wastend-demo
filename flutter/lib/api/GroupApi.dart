import 'package:wastend/api/Api.dart';
import 'package:wastend/api/ApiResponse.dart';

class GroupApi {
  static Future<bool> isInGroup() async {
    ApiResponse response = await Api.apiGet('group');
    return response.success;
  }
  
  static Future<bool> createGroup() async {
    ApiResponse response = await Api.apiPost('group', {});
    return response.success;
  }
}