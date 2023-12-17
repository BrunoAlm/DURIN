import 'package:app/src/navigation/features/home/home_page.dart';
import 'package:app/src/navigation/features/printers/printers_page.dart';
import 'package:app/src/navigation/features/reports/reports_page.dart';
import 'package:app/src/navigation/features/settings/settings_Page.dart';
import 'package:app/src/navigation/store/navigation_store.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final navStore = NavigationStore();

  final List<Widget> pages = [
    const HomePage(),
    const PrintersPage(),
    const ReportsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contadores'),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            NavigationRail(
              selectedIndex: navStore.actualPage,
              onDestinationSelected: (int index) {
                setState(() {
                  navStore.selectedPage = index;
                });
              },
              labelType: NavigationRailLabelType.selected,
              leading: FloatingActionButton(
                elevation: 0,
                onPressed: () {
                  print('atualizando impressoras');
                },
                child: const Icon(Icons.refresh),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  );
                },
                icon: const Icon(Icons.settings),
              ),
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.local_printshop_outlined),
                  selectedIcon: Icon(Icons.local_printshop_rounded),
                  label: Text('Impressoras'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.receipt_outlined),
                  selectedIcon: Icon(Icons.receipt_sharp),
                  label: Text('Relatórios'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            // This is the main content.
            Expanded(child: pages.elementAt(navStore.actualPage)),
          ],
        ),
      ),
    );
  }
}
