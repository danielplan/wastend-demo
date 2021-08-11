import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Api {
  static const String URL = 'http://10.0.2.2:3000/api';
  static final STORAGE = new FlutterSecureStorage();

  static List<String> parseErrors(dynamic response) {
    List<dynamic> _errors = jsonDecode(response['message'])['errors'];
    return _errors.map((e) => e.toString()).toList();
  }

}
