import 'package:flutter/material.dart';
import 'package:gamaiaapp/constants.dart';
import 'package:gamaiaapp/helper/ShowSnakbar.dart';
import 'package:gamaiaapp/services/auth_service.dart';
import 'package:gamaiaapp/widgets/custom_button.dart';
import 'package:gamaiaapp/Pages/register/step_fullname.dart';
import 'package:gamaiaapp/Pages/register/step_phone.dart';
import 'package:gamaiaapp/Pages/register/step_credentials.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _step = 0;
  final _fullNameController   = TextEditingController();
  final _phoneController      = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _passwordController   = TextEditingController();
  bool isLoading = false;

  final authService = AuthService();

  void _nextStep() {
    if (_step < 2) {
      setState(() => _step++);
    } else {
      _submit();
    }
  }

  Future<void> _submit() async {
    if ([_fullNameController.text, _phoneController.text,
         _nationalIdController.text, _passwordController.text]
        .any((s) => s.trim().isEmpty)) {
      if (!mounted) return;
      showSnackBar(context, 'جميع الحقول مطلوبة');
      return;
    }

    setState(() => isLoading = true);

    try {
      await authService.register({
        'fullName'   : _fullNameController.text.trim(),
        'phone'      : _phoneController.text.trim(),
        'nationalId' : _nationalIdController.text.trim(),
        'password'   : _passwordController.text.trim(),
      });

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');

    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString().replaceAll('Exception: ', ''));
    } finally {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset  = MediaQuery.of(context).viewInsets.bottom;
    final viewHeight   = MediaQuery.of(context).size.height - bottomInset;

    final stepsWidgets = [
      FullNameStep(controller: _fullNameController),
      PhoneStep(controller: _phoneController),
      CredentialsStep(
        nationalController: _nationalIdController,
        passwordController: _passwordController,
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.only(bottom: bottomInset),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewHeight),
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
                  _Header(title: 'تسجيل حساب جديد'),
                  const SizedBox(height: 12),
                  _ProgressBar(step: _step, length: stepsWidgets.length),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        stepsWidgets[_step],
                        const SizedBox(height: 24),
                        CustomButton(
                          text: isLoading || _step < 2 ? 'التالي' : 'تسجيل',
                          onPressed: isLoading ? () {} : _nextStep,
                        ),
                        const SizedBox(height: 12),
                        _Footer(
                          onSwitch: () {
                            if (mounted) {
                              Navigator.pushReplacementNamed(context, '/login');
                            }
                          },
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

class _Header extends StatelessWidget {
  final String title;
  const _Header({required this.title});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      color: kSecondaryColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class _ProgressBar extends StatelessWidget {
  final int step, length;
  const _ProgressBar({required this.step, required this.length});

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl, 
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 40,
        height: 6,
        decoration: BoxDecoration(
          color: i == step ? kSecondaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(3),
        ),
      )),
    ),
  );
}

class _Footer extends StatelessWidget {
  final VoidCallback onSwitch;
  const _Footer({required this.onSwitch});
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'بالنقر على "تسجيل"، أنت توافق على شروط الخدمة و سياسة الخصوصية',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      ),
      TextButton(
        onPressed: onSwitch,
        child: const Text('لديك حساب فعلاً؟ اذهب لتسجيل الدخول'),
      ),
    ],
  );
}
