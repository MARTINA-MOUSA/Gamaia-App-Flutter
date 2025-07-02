import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gamaiaapp/Pages/Associations_Page.dart';
import 'package:gamaiaapp/Pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'package:gamaiaapp/Pages/Home Page.dart';
import 'package:gamaiaapp/Pages/Login-page.dart';
import 'pages/register/register_page.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedLang = prefs.getString('lang') ?? 'ar';

  runApp(
  EasyLocalization(
    supportedLocales: [Locale('en'), Locale('ar')], 
    path: 'assets/langs',
    fallbackLocale: Locale('ar'),
    startLocale: Locale(savedLang), 
    child: const GamaiaApp(),
  ),
);

}

class GamaiaApp extends StatelessWidget {
  const GamaiaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: MaterialApp(
        title: 'Gamaia',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kBackgroundColor,
        ),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/main': (context) => const MainScreen(),
          '/profile': (context) =>  ProfilePage(),
          '/associations': (context) => AssociationsPage(),
        },
      ),
    );
  }
}
