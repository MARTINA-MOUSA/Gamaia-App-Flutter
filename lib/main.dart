import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'constants.dart';
import 'package:gamaiaapp/Pages/Home Page.dart';
import 'package:gamaiaapp/Pages/Login-page.dart';
import 'pages/register/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/langs',
      fallbackLocale: const Locale('ar'),
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
      },
    );
  }
}
