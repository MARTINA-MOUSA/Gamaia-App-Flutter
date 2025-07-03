import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gamaiaapp/Pages/Associations_Page.dart';
import 'package:gamaiaapp/Pages/payments_page.dart';
import 'package:gamaiaapp/Pages/profile_page.dart';
import 'package:gamaiaapp/Pages/wallet_page.dart';
import 'package:gamaiaapp/constants.dart';
import 'package:gamaiaapp/Pages/Home Page.dart';
import 'package:gamaiaapp/Pages/Login-page.dart';
import 'package:gamaiaapp/pages/register/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final savedLang = prefs.getString('lang') ?? 'ar';

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/langs',
      fallbackLocale: const Locale('ar'),
      startLocale: Locale(savedLang),
      saveLocale: true, 
      child: const GamaiaApp(),
    ),
  );
}

class GamaiaApp extends StatelessWidget {
  const GamaiaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamaia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/main': (context) => const MainScreen(),
        '/profile': (context) => ProfilePage(),
        '/associations': (context) => AssociationsPage(),
        '/wallet': (context) => const WalletPage(),
        '/payments': (context) => const PaymentsPage(),        
      },
    );
  }
}
