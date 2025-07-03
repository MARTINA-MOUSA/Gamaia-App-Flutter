import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gamaiaapp/constants.dart';
import 'package:gamaiaapp/Pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

void _onItemTapped(int index) {
  if (index == 3) {
    Navigator.pushNamed(context, '/wallet');
  } else if (index == 4) {
    Navigator.pushNamed(context, '/payments'); 
  } else {
    setState(() => _selectedIndex = index);
  }
}

  Widget _buildCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return const HomeTab();
      case 1:
        return Center(child: Text(tr('my_groups'), style: const TextStyle(fontSize: 20)));
      case 2:
        return Center(child: Text(tr('subscription'), style: const TextStyle(fontSize: 20)));
      case 4:
        return Center(child: Text(tr('payments'), style: const TextStyle(fontSize: 20)));
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
            },
            child: const Icon(Icons.account_circle, color: Colors.white, size: 28),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: PopupMenuButton(
              icon: const Icon(Icons.language, color: Colors.white),
              onSelected: (value) {
                context.setLocale(Locale(value));
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'ar', child: Text('العربية')),
                PopupMenuItem(value: 'en', child: Text('English')),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12, right: 4),
            child: Icon(Icons.notifications, color: Colors.white, size: 28),
          ),
        ],
      ),

      // 🔑 Force rebuild on locale change
      body: KeyedSubtree(
        key: ValueKey(context.locale.languageCode),
        child: _buildCurrentScreen(),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFB8E8E2),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: tr('home')),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: tr('my_groups')),
          BottomNavigationBarItem(icon: Icon(Icons.subscriptions), label: tr('subscription')),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: tr('my_card')),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: tr('payments')),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('summer_ready'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(tr('join_now'), style: const TextStyle(color: Colors.blue, fontSize: 14)),
                      const SizedBox(height: 2),
                      Text(tr('discount'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.wb_sunny, color: Colors.orange),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFB8E8E2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('invite_discount'), style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(tr('invite_text'), style: const TextStyle(fontSize: 13)),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: kPrimaryColor,
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: kPrimaryColor),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: Text(tr('send_invite')),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  children: const [
                    Icon(FontAwesomeIcons.handsClapping, size: 32),
                    SizedBox(height: 8),
                    Icon(FontAwesomeIcons.peopleGroup, size: 32),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
