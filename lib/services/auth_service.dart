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

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _api.get('/api/userData/profile');

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body is List && body.isNotEmpty) {
          return body[0];
        }

        if (body is Map<String, dynamic>) {
          return body;
        }

        throw Exception('صيغة بيانات غير متوقعة');
      } else {
        throw Exception('فشل تحميل بيانات الملف الشخصي');
      }
    } catch (e) {
      throw Exception('حدث خطأ أثناء تحميل الملف الشخصي');
    }
  }

  Future<String?> getProfileImageUrl() async {
    try {
      final profileData = await getProfile();
      final imageName = profileData['profileImage'];

      if (imageName != null && imageName.isNotEmpty) {
        return "https://api.technologytanda.com/api/userData/uploads/$imageName";
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("فشل تحميل صورة الملف الشخصي");
    }
  }
}
