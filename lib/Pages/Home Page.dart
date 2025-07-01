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
    const Center(child: Text('المدفوعات')),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          title: const Text('الرئيسية', style: TextStyle(color: Colors.white)),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
            const Padding(
              padding: EdgeInsets.only(left: 12, right: 4),
              child: Icon(Icons.notifications, color: Colors.white, size: 28),
            ),
          ],
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFB8E8E2),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'جمعياتي'),
            BottomNavigationBarItem(icon: Icon(Icons.subscriptions), label: 'إشتراكي'),
            BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'كارتي'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'المدفوعات'),
          ],
        ),
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
                // النصوص
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'خليك جاهز للصيف',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'إشتراك في جمعيه',
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '%20 خصم علي الرسوم',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.wb_sunny, color: Colors.orange),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // النصوص
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'خصم 300 رس ليك ولأصحابك.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'إبعت دعوات أكتر، إستفيد بخصومات أكبر',
                        style: TextStyle(fontSize: 13),
                      ),
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
                          child: const Text('إبعت دعوة'),
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
