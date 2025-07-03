import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gamaiaapp/constants.dart';

class JoinJamaiaPage extends StatelessWidget {
  const JoinJamaiaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: const Color(0xFFF0F7F4),
      appBar: AppBar(
        title: Text(tr('join_jamaia')),
        backgroundColor: kPrimaryColor,
        foregroundColor: kBackgroundColor,
        elevation: 1,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildJoinCard(
              isArabic: isArabic,
              title: tr('join_regular'),
              description: tr('join_regular_desc'),
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _buildJoinCard(
              isArabic: isArabic,
              title: tr('join_saving'),
              description: tr('join_saving_desc'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJoinCard({
    required bool isArabic,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: isArabic
              ? [
                  const Icon(Icons.double_arrow, color: Colors.green),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(description, textAlign: TextAlign.right),
                      ],
                    ),
                  ),
                ]
              : [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(description),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.double_arrow, color: Colors.green),
                ],
        ),
      ),
    );
  }
}
