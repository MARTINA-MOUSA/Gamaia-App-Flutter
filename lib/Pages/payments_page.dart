import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: Text(tr('payments')),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset('assets/langs/payment.png', height: 150),
            const SizedBox(height: 16),
            Text(
              tr('join_payment_message'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              tr('join_payment_subtext'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check_circle),
              label: Text(tr('join_new_jamaia')),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.white,
                foregroundColor: Colors.teal,
                side: const BorderSide(color: Colors.teal),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _paymentTile(Icons.settings, tr('payment_settings')),
                _paymentTile(Icons.verified_user, tr('account_ready')),
                _paymentTile(Icons.attach_money, tr('payment_history')),
                _paymentTile(Icons.lock, tr('payment_policy')),
                _paymentTile(Icons.support_agent, tr('support')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentTile(IconData icon, String label) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.teal, size: 28),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
