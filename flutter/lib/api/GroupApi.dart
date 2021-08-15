import 'package:wastend/api/Api.dart';
import 'package:wastend/api/ApiResponse.dart';
import 'package:wastend/models/User.dart';

class GroupApi {
  static Future<bool> isInGroup() async {
    ApiResponse response = await Api.apiGet('group');
    return response.success;
  }

  static Future<bool> createGroup() async {
    ApiResponse response = await Api.apiPost('group', {});
    return response.success;
  }

  static Future<List<User>> getMembers() async {
    ApiResponse response = await Api.apiGet('group');
    if (response.success && response.data != null) {
      return response.data['members']
          .map<User>((item) => User.fromJson(item))
          .toList();
    }
    return [];
  }

  static Future<ApiResponse> addMember(String username) async {
    return await Api.apiPut('group/add/$username', {});
  }
}
