import 'package:wastend/api/Api.dart';
import 'package:wastend/api/ApiResponse.dart';
import 'package:wastend/models/User.dart';

class AuthApi {
  static Future<ApiResponse> login(String username, String password) async {
    ApiResponse response = await Api.apiPost(
        'auth/login', {'username': username, 'password': password});
    if (response.success) {
      await Api.STORAGE.write(key: 'token', value: response.data['token']);
    }
    return response;
  }

  static Future<ApiResponse> register(
      String username, String displayName, String password) async {
    ApiResponse response = await Api.apiPost('auth/register', {
      'username': username,
      'password': password,
      'displayName': displayName
    });
    if (response.success) {
      await Api.STORAGE.write(key: 'token', value: response.data['token']);
    }
    return response;
  }

  static Future<bool> logout() async {
    await Api.STORAGE.delete(key: 'token');
    return true;
  }

  static Future<bool> isLoggedIn() async {
    String? token = await Api.STORAGE.read(key: 'token');
    return token != null;
  }

  static Future<User> getCurrentUser() async {
    ApiResponse response = await Api.apiGet('auth');
    return User.fromJson(response.data);
  }

  static Future<ApiResponse> update(User user, String? password) async {
    return await Api.apiPut('auth', {
      'username': user.username,
      'password': password,
      'displayName': user.displayName
    });
  }
}
