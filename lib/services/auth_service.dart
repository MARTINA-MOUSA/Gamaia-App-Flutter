import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamaiaapp/helper/api_client.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthService {
  final ApiClient _api = ApiClient();

  // حفظ بيانات المستخدم في SharedPreferences
  Future<void> saveUserToPrefs(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', user['fullName'] ?? '');
    await prefs.setString('role', user['role'] ?? '');
    await prefs.setDouble('walletBalance', (user['walletBalance'] ?? 0).toDouble());
  }

  Future<bool> login(String nationalId, String password) async {
    try {
      final response = await _api.post('/api/auth/login', {
        'nationalId': nationalId,
        'password': password,
      });

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final token = body['token'];
        final user = body['user'];

        await _api.saveToken(token);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nationalId', nationalId);
        await saveUserToPrefs(user);

        return true;
      } else {
        final error = jsonDecode(response.body)['message'] ?? tr('login_failed');
        throw Exception(error);
      }
    } catch (e) {
      throw Exception(tr('login_failed'));
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
        final error = jsonDecode(response.body)['message'] ?? tr('register_failed');
        throw Exception(error);
      }
    } catch (e) {
      throw Exception(tr('register_failed'));
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _api.get('/api/userData/profile');

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body is List && body.isNotEmpty) {
          await saveUserToPrefs(body[0]);
          return body[0];
        }

        if (body is Map<String, dynamic>) {
          await saveUserToPrefs(body);
          return body;
        }

        throw Exception(tr('unexpected_data_format'));
      } else {
        throw Exception(tr('profile_load_failed'));
      }
    } catch (e) {
      throw Exception(tr('profile_load_failed'));
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
      throw Exception(tr('profile_image_load_failed'));
    }
  }

  Future<Map<String, dynamic>> topUpWallet(double amount, double currentBalance) async {
    try {
      final res = await _api.topUpWallet(amount, currentBalance);

      if (res['success'] == true) {
        final newBalance = res['newBalance']['val'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setDouble('walletBalance', newBalance);
      }

      return res;
    } catch (e) {
      throw Exception(tr('top_up_failed'));
    }
  }
}
