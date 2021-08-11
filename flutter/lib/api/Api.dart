import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wastend/api/ApiResponse.dart';
import 'package:wastend/api/AuthApi.dart';

class Api {
  static const String URL = 'http://10.0.2.2:3000/api';
  static final STORAGE = new FlutterSecureStorage();

  static List<String> parseErrors(http.Response response) {
    dynamic data = jsonDecode(response.body);
    List<dynamic> _errors = jsonDecode(data['message'])['errors'];
    return _errors.map((e) => e.toString()).toList();
  }

  static ApiResponse parseResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return new ApiResponse(success: true, data: jsonDecode(response.body));
    }
    if(response.statusCode == 401) {
      AuthApi.logout();
      return new ApiResponse(success: false);
    }
    return new ApiResponse(success: false, errors: parseErrors(response));
  }

  static Future<Map<String, String>> getHeader() async {
    String? token = await STORAGE.read(key: 'token');
    if (token != null) {
      return {
        'Authorization': 'Bearer $token'
      };
    }
    return {};
  }

  static getUri(String endpoint) {
    return Uri.parse('$URL/$endpoint');
  }

  static Future<ApiResponse> apiGet(String endpoint) async {
    Uri uri = getUri(endpoint);
    http.Response response = await http.get(uri, headers: await getHeader());
    return parseResponse(response);
  }

  static Future<ApiResponse> apiPost(String endpoint, Object? payload) async {
    Uri uri = getUri(endpoint);
    http.Response response = await http.post(uri, headers: await getHeader(), body: payload);
    return parseResponse(response);
  }

  static Future<ApiResponse> apiPatch(String endpoint, Object? payload) async {
    Uri uri = getUri(endpoint);
    http.Response response = await http.patch(uri, headers: await getHeader(), body: payload);
    return parseResponse(response);
  }

  static Future<ApiResponse> apiPut(String endpoint, Object? payload) async {
    Uri uri = getUri(endpoint);
    http.Response response = await http.put(uri, headers: await getHeader(), body: payload);
    return parseResponse(response);
  }
}
