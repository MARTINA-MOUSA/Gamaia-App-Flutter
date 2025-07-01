import 'package:flutter/material.dart';
import 'package:gamaiaapp/widgets/custom_text_field.dart';

class PhoneStep extends StatelessWidget {
  final TextEditingController controller;
  const PhoneStep({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: 'الهاتف',
       hint: '01xxxxxxxx',
      controller: controller,
    );
  }
}