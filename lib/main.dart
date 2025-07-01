import 'package:flutter/material.dart';
import 'package:gamaiaapp/Pages/Home Page.dart';
import 'constants.dart';
import 'package:gamaiaapp/Pages/Login-page.dart';
import 'pages/register/register_page.dart';

void main() {
  runApp(const GamaiaApp());
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(), 
      },
    );
  }
}
