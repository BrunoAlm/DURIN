import 'package:app/src/navigation/navigation_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contadores Durín',
      theme: ThemeData(colorSchemeSeed: const Color.fromARGB(255, 134, 1, 1)),
      home: const NavigationPage(),
    );
  }
}