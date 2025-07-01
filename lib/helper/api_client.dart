import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class ApiClient {
  final String baseUrl;
  ApiClient({this.baseUrl = kApiBaseUrl});

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<http.Response> post(String path, Map<String, dynamic> data, {bool isFormData = false}) async {
    final uri = Uri.parse('$baseUrl$path');
    final headers = {
      'Content-Type': isFormData ? 'application/x-www-form-urlencoded' : 'application/json',
    };

    final token = await getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final body = isFormData ? data : jsonEncode(data);
    return http.post(uri, headers: headers, body: body);
  }
}
