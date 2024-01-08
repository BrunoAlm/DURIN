import 'package:app/src/app_module.dart';
import 'package:app/src/pages/features/home/home_page.dart';
import 'package:app/src/pages/features/printers/printers_page.dart';
import 'package:app/src/pages/features/reports/reports_page.dart';
import 'package:app/src/pages/features/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:app/src/pages/navigation_page.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.asNewInstance();
void main() {
  AppModule.start();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contadores Durín',
      theme: ThemeData(colorSchemeSeed: const Color.fromARGB(255, 97, 1, 1)),
      initialRoute: '/',
      routes: {
        '/': (context) => const NavigationPage(),
        '/home': (context) => const HomePage(),
        '/printers': (context) => const PrintersPage(),
        '/reports': (context) => const ReportsPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
