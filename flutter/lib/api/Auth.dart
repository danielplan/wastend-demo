import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wastend/api/Api.dart';

class Auth {
  static Future<List<String>?> login(String username, String password) async {
    Uri uri = Uri.parse("${Api.URL}/auth/login");
    http.Response response = await http
        .post(uri, body: {'username': username, 'password': password});
    var data = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      await Api.STORAGE.write(key: 'token', value: data['token']);
      return null;
    }
    return Api.parseErrors(data);
  }

  static Future<List<String>?> register(
      String username, String displayName, String password) async {
    Uri uri = Uri.parse("${Api.URL}/auth/register");
    http.Response response = await http.post(uri, body: {
      'username': username,
      'password': password,
      'displayName': displayName
    });
    var data = jsonDecode(response.body);
    print(data);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      await Api.STORAGE.write(key: 'token', value: data['token']);
      return null;
    }
    return Api.parseErrors(data);
  }

  static Future<bool> logout() async {
    await Api.STORAGE.delete(key: 'token');
    return true;
  }

  static Future<bool> isLoggedIn() async {
    String? token = await Api.STORAGE.read(key: 'token');
    return token != null;
  }
}
