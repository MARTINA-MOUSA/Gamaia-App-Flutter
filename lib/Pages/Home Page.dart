import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamaiaapp/constants.dart';
import 'package:gamaiaapp/Pages/profile_page.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const Center(child: Text('جمعياتي')),
    const Center(child: Text('إشتراكي')),
    const Center(child: Text('كارتي')),
    const Center(child: Text('الإشعارات')),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: const Text('الرئيسية', style: TextStyle(color: Colors.white)),
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.notifications, color: Colors.white, size: 28),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
              child: const Icon(Icons.account_circle, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'جمعياتي'),
          BottomNavigationBarItem(icon: Icon(Icons.subscriptions), label: 'إشتراكي'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'كارتي'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'الإشعارات'),
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
          // بطاقة الصيف
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
              children: [
                const Icon(Icons.wb_sunny, color: Colors.orange),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'خليك جاهز للصيف',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'إشترك في جمعيه',
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        '%20 خصم علي الرسوم',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.beach_access, size: 40, color: kPrimaryColor),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // بطاقة الدعوة
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFB8E8E2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Column(
                  children: const [
                    Icon(FontAwesomeIcons.peopleGroup, size: 32),
                    SizedBox(height: 8),
                    Icon(FontAwesomeIcons.userFriends, size: 32),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'خصم 300 رس لك ولأصحابك.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'إبعت دعوات أكتر، إستفيد بخصومات أكثر',
                        style: TextStyle(fontSize: 13),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: kPrimaryColor,
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: kPrimaryColor),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: const Text('إبعت دعوة'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
