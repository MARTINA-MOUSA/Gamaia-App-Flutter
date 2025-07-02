import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamaiaapp/helper/api_client.dart';

class AuthService {
  final _api = ApiClient();

  Future<bool> login(String nationalId, String password) async {
    try {
      final response = await _api.post('/api/auth/login', {
        'nationalId': nationalId,
        'password': password,
      });

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final token = body['token'];

        await _api.saveToken(token);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nationalId', nationalId);

        return true;
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'فشل تسجيل الدخول';
        throw Exception(error);
      }
    } catch (e) {
      throw Exception('حدث خطأ أثناء تسجيل الدخول');
    }
  }

  // ✅ التعديل هنا: نستقبل البيانات من RegisterPage
  Future<bool> register({
    required String fullName,
    required String nationalId,
    required String phone,
    required String address,
    required String role,
    required String password,
  }) async {
    try {
      final response = await _api.post(
        '/api/userData/admin/create-user',
        {
          "fullName": fullName,
          "nationalId": nationalId,
          "phone": phone,
          "address": address,
          "role": role,
          "password": password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'فشل تسجيل المستخدم';
        throw Exception(error);
      }
    } catch (e) {
      throw Exception('فشل تسجيل المستخدم');
    }
  }
}
