import 'package:flutter/material.dart';
import 'package:gamaiaapp/widgets/custom_text_field.dart';

class FullNameStep extends StatelessWidget {
  final TextEditingController controller;
  const FullNameStep({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: 'الاسم الكامل',
       hint: 'الاسم ',
      controller: controller,
    );
  }
}