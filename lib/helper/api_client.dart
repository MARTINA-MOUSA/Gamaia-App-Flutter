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

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
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
    final response = await http.post(uri, headers: headers, body: body);

    _logResponse(path, response);
    return response;
  }

  Future<http.Response> get(String path) async {
    final uri = Uri.parse('$baseUrl$path');
    final headers = {
      'Content-Type': 'application/json',
    };

    final token = await getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(uri, headers: headers);

    _logResponse(path, response);
    return response;
  }

  Future<http.Response> put(String path, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$path');
    final headers = {
      'Content-Type': 'application/json',
    };

    final token = await getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final body = jsonEncode(data);
    final response = await http.put(uri, headers: headers, body: body);

    _logResponse(path, response);
    return response;
  }

  Future<http.Response> delete(String path) async {
    final uri = Uri.parse('$baseUrl$path');
    final headers = {
      'Content-Type': 'application/json',
    };

    final token = await getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.delete(uri, headers: headers);

    _logResponse(path, response);
    return response;
  }

  void _logResponse(String path, http.Response response) {
    print('[$path] Status: ${response.statusCode}');
    print('[$path] Body: ${response.body}');
  }

Future<Map<String, dynamic>> topUpWallet(double amount, double currentBalance) async {
  try {
    final res = await post('/api/payments/topup', {
      'amount': amount.toInt(),
    });

    final json = jsonDecode(res.body);

    if (res.statusCode == 200 && json['success'] == true) {
      final newBalance = currentBalance + amount;

      json['newBalance'] = {'val': newBalance};

      return json;
    } else {
      throw Exception(json['message'] ?? 'فشل في الشحن');
    }
  } catch (e) {
    throw Exception('حدث خطأ أثناء شحن المحفظة: $e');
  }
}
Future<Map<String, dynamic>> getSuggestions(int amount) async {
  final res = await post('/api/payments/pay/suggest', {
    'enter': amount,
  });
  final json = jsonDecode(res.body);
  if (res.statusCode == 200 && json['success'] == true) {
    return json;
  } else {
    throw Exception(json['message'] ?? 'فشل جلب الاقتراحات');
  }
}
}
