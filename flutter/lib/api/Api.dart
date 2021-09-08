import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wastend/api/ApiResponse.dart';
import 'package:wastend/api/AuthApi.dart';
import 'package:wastend/config.dart';

class Api {
  static const String URL = '$API_HOST/api';
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
    if (response.statusCode == 401) {
      AuthApi.logout();
      return new ApiResponse(success: false);
    }
    return new ApiResponse(success: false, errors: parseErrors(response));
  }

  static Future<Map<String, String>> getHeader() async {
    String? token = await STORAGE.read(key: 'token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      return {
        ...header,
        'Authorization': 'Bearer $token',
      };
    }
    return header;
  }

  static getUri(String endpoint) {
    return Uri.parse('$URL/$endpoint');
  }

  static Future<ApiResponse> apiGet(String endpoint) async {
    Uri uri = getUri(endpoint);
    try {
      http.Response response = await http.get(uri, headers: await getHeader());
      return parseResponse(response);
    } catch (e) {
      print(e);
      return new ApiResponse(success: false, failed: true);
    }
  }

  static Future<ApiResponse> apiPost(String endpoint, Object? payload) async {
    Uri uri = getUri(endpoint);
    try {
      http.Response response = await http.post(uri,
          headers: await getHeader(), body: jsonEncode(payload));
      return parseResponse(response);
    } catch (e) {
      print(e);
      return new ApiResponse(success: false, failed: true);
    }
  }

  static Future<ApiResponse> apiPatch(String endpoint, Object? payload) async {
    Uri uri = getUri(endpoint);
    try {
      http.Response response = await http.patch(uri,
          headers: await getHeader(), body: jsonEncode(payload));
      return parseResponse(response);
    } catch (e) {
      print(e);
      return new ApiResponse(success: false, failed: true);
    }
  }

  static Future<ApiResponse> apiPut(String endpoint, Object? payload) async {
    Uri uri = getUri(endpoint);
    try {
      http.Response response = await http.put(uri,
          headers: await getHeader(), body: jsonEncode(payload));
      return parseResponse(response);
    } catch (e) {
      print(e);
      return new ApiResponse(success: false, failed: true);
    }
  }

  static Future<ApiResponse> apiDelete(String endpoint) async {
    Uri uri = getUri(endpoint);
    try {
      http.Response response =
          await http.delete(uri, headers: await getHeader());
      return parseResponse(response);
    } catch (e) {
      print(e);
      return new ApiResponse(success: false, failed: true);
    }
  }
}
