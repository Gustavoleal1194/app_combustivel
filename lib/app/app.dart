import 'package:app_combustivel/app/modules/calculator_page.dart';
import 'package:app_combustivel/app/modules/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Calculator',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/calculatorPage': (_) => CalculatorPage(),
      },
    );
  }
}
