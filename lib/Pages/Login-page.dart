import 'package:flutter/material.dart';
import 'package:gamaiaapp/constants.dart';
import 'package:gamaiaapp/helper/ShowSnakbar.dart';
import 'package:gamaiaapp/services/auth_service.dart';
import 'package:gamaiaapp/widgets/custom_button.dart';
import 'package:gamaiaapp/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nationalIdController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  final authService = AuthService();

  Future<void> _login() async {
    final id = nationalIdController.text.trim();
    final pw = passwordController.text.trim();

    if (id.isEmpty || pw.isEmpty) {
      if (!mounted) return;
      showSnackBar(context, 'من فضلك أدخل الرقم القومي وكلمة المرور');
      return;
    }

    setState(() => isLoading = true);

    try {
      final success = await authService.login(id, pw);
      if (!mounted) return;

      if (success) {
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        showSnackBar(
            context, 'فشل تسجيل الدخول. تحقق من الرقم القومي وكلمة المرور.');
      }
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString().replaceAll('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final availableHeight = MediaQuery.of(context).size.height - bottomInset;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.only(bottom: bottomInset),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: availableHeight),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'تسجيل الدخول',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Input Fields and Button
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'الرقم القومي',
                          hint: 'أدخل الرقم القومي',
                          controller: nationalIdController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'كلمة المرور',
                          hint: '********',
                          controller: passwordController,
                          obscure: true,
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: isLoading ? 'جار تسجيل الدخول' : 'تسجيل الدخول',
                          onPressed: isLoading ? () {} : _login,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('ليس لديك حساب؟'),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/register'),
                              child: const Text('إنشاء حساب جديد'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
