import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:gamaiaapp/constants.dart';
import 'package:gamaiaapp/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final AuthService _authService = AuthService();

  double balance = 0.0;
  String userName = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWalletInfo();
  }

  Future<void> _loadWalletInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final fullName = prefs.getString('fullName') ?? '';
      final role = prefs.getString('role') ?? '';
      final savedBalance = prefs.getDouble('walletBalance') ?? 0.0;

      setState(() {
        balance = savedBalance;
        userName = role == 'admin' ? 'Admin' : fullName;
        isLoading = false;
      });
    } catch (e) {
      _showSnackBar(tr('wallet_balance_load_failed'));
      setState(() => isLoading = false);
    }
  }

  Future<void> _topUpWallet(double amount) async {
    try {
      final result = await _authService.topUpWallet(amount, balance);
      if (result['success'] == true) {
        _showSnackBar(result['message'].toString(), success: true);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setDouble('walletBalance', result['newBalance']['val']);
        setState(() {
          balance = result['newBalance']['val'];
        });
      } else {
        _showSnackBar(result['message'].toString());
      }
    } catch (e) {
      _showSnackBar(tr('top_up_failed'));
    }
  }

  void _showTopUpDialog() {
    final tempController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: Directionality.of(context),
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(tr('recharge_wallet'), style: const TextStyle(fontWeight: FontWeight.bold)),
            content: TextField(
              controller: tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: tr('enter_amount'),
                border: const OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(tr('cancel'), style: const TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () async {
                  final amount = double.tryParse(tempController.text);
                  if (amount == null || amount <= 0) {
                    _showSnackBar(tr('enter_valid_amount'));
                    return;
                  }

                  Navigator.pop(context);
                  await _topUpWallet(amount);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(tr('accept')),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSnackBar(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? kPrimaryColor : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: Text(tr('wallet')),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildCardViewLTR(), // Always in English direction
                  const SizedBox(height: 20),
                  _buildBalanceBox(),
                  const SizedBox(height: 20),
                  _buildTopUpSection(),
                ],
              ),
            ),
    );
  }

  Widget _buildCardViewLTR() {
    return Directionality(
      textDirection: ui.TextDirection.ltr, // Always LTR for card
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF00B8A9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/langs/suaid_logo.png', height: 40),
            ),
            const SizedBox(height: 20),
            const Text(
              '1234 5678 9231 2356',
              style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const Text(
              '1234',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              userName,
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset('assets/langs/mastercard_logo.png', height: 40),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tr('wallet_balance'), style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text(
                'SAR ${balance.toStringAsFixed(2)}',
                style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.account_balance_wallet, color: kPrimaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopUpSection() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _showTopUpDialog,
        style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
        child: Text(tr('top_up_wallet')),
      ),
    );
  }
}
