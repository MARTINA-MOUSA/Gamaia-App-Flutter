import 'package:flutter/material.dart';
import 'package:gamaiaapp/widgets/custom_text_field.dart';

class CredentialsStep extends StatelessWidget {
  final TextEditingController nationalController;
  final TextEditingController passwordController;

  const CredentialsStep({
    required this.nationalController,
    required this.passwordController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'الرقم القومي',
           hint: 'أدخل الرقم القومي',
          controller: nationalController,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'كلمة المرور',
           hint: 'ادخل كلمة المرور',
          controller: passwordController,
          obscure: true,
        ),
      ],
    );
  }
}