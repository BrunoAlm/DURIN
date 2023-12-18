import 'package:app/src/navigation/navigation_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contadores Durín',
      theme: ThemeData(colorSchemeSeed: Color.fromARGB(255, 97, 1, 1)),
      home: const NavigationPage(),
    );
  }
}
