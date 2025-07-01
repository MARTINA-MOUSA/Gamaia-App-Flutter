import 'dart:convert';
import 'package:gamaiaapp/helper/api_client.dart';

class AuthService {
  final _api = ApiClient();

  Future<bool> login(String nationalId, String password) async {
    final response = await _api.post('/api/auth/login', {
      'nationalId': nationalId,
      'password': password,
    });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final token = body['token'];

      // حفظ التوكن في التخزين المحلي
      await _api.saveToken(token);
      return true;
    } else {
      throw Exception(jsonDecode(response.body)['message'] ?? 'فشل تسجيل الدخول');
    }
  }

  Future register(Map<String, String> data) async {
    final response = await _api.post('/api/auth/register', data, isFormData: true);
    return response;
  }
}
