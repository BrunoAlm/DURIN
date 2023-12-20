import 'package:app/main.dart';
import 'package:app/src/navigation/features/home/home_page.dart';
import 'package:app/src/navigation/features/printers/printers_page.dart';
import 'package:app/src/navigation/features/printers/printers_controller.dart';
import 'package:app/src/navigation/features/reports/reports_page.dart';
import 'package:app/src/navigation/features/settings/settings_Page.dart';
import 'package:app/src/navigation/navigation_store.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final NavigationStore _navStore = di();
  final PrintersController _printersCt = di();

  final List<Widget> pages = [
    const HomePage(),
    const PrintersPage(),
    const ReportsPage()
  ];

  @override
  void initState() {
    _printersCt.init();
    super.initState();
  }

  @override
  void dispose() {
    _printersCt.dispose();
    super.dispose();
  }

  void confirmRequest() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Atualização de contadores"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                "Tem certeza de que deseja atualizar os contadores das impressoras?"),
            const Divider(),
            Text(
              "Essa ação pode demorar até 10min",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.red),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              var printers = _printersCt.printers.value;
              List<int> printersId = [];
              for (var printer in printers) {
                printersId.add(printer.id);
              }
              _printersCt.updatePrinters(printersId);
            },
            child: const Text('Sim'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Ação a ser executada se o usuário cancelar a atualização
            },
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

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
              selectedIndex: _navStore.actualPage,
              onDestinationSelected: (int index) {
                setState(() {
                  _navStore.selectedPage = index;
                });
              },
              labelType: NavigationRailLabelType.selected,
              leading: FloatingActionButton(
                elevation: 0,
                onPressed: confirmRequest,
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
            Expanded(child: pages.elementAt(_navStore.actualPage)),
          ],
        ),
      ),
    );
  }
}
