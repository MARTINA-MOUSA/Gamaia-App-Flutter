import 'package:flutter/material.dart';
import 'package:gamaiaapp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamaiaapp/services/auth_service.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();

  Map<String, dynamic>? userData;
  bool isLoading = true;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final data = await _authService.getProfile();
      final imageUrl = await _authService.getProfileImageUrl();

      setState(() {
        userData = data;
        _nameController.text = data['fullName'] ?? '';
        _idController.text = data['nationalId'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        userData!['profileImageUrl'] = imageUrl;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: Text('profile'.tr()),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        foregroundColor: kBackgroundColor,
        elevation: 1,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  userData?['profileImageUrl'] != null
                                      ? NetworkImage(userData!['profileImageUrl'])
                                      : const AssetImage('assets/langs/default_profile.jpg') as ImageProvider,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.deepPurple,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(6),
                                child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        buildInfoRow('full_name'.tr(), _nameController.text),
                        buildInfoRow('national id'.tr(), _idController.text),
                        buildInfoRow('phone'.tr(), _phoneController.text),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.edit),
                    label: Text('edit profile'.tr()),
                    onPressed: () {
                      
                    },
                  ),

                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('recent_activities'.tr(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFE5F0FF),
                            child: Icon(Icons.attach_money, color: Colors.blue),
                          ),
                          title: Text('recharge_wallet'.tr()),
                          subtitle: Text('recharged_wallet_info'.tr()),
                          trailing: Text('21 ${'minutes_ago'.tr()}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: Colors.grey))),
          Expanded(child: Text(value, textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
