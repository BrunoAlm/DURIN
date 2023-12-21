import 'package:app/main.dart';
import 'package:app/src/navigation/features/printers/components/printers_cards.dart';
import 'package:app/src/navigation/features/printers/printers_controller.dart';
import 'package:app/src/navigation/features/printers/printers_entity.dart';
import 'package:flutter/material.dart';

class PrintersPage extends StatefulWidget {
  const PrintersPage({super.key});

  @override
  State<PrintersPage> createState() => _PrintersPageState();
}

class _PrintersPageState extends State<PrintersPage> {
  final PrintersController _printersCt = di();

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

  List<PrintersEntity> filterPrintersName(
      List<PrintersEntity> printers, List<String> elements) {
    var filteredPrinters = printers.where((printer) {
      for (var element in elements) {
        if (printer.name.startsWith(element)) {
          return true;
        }
      }
      return false;
    }).toList();
    return filteredPrinters;
  }

  @override
  Widget build(BuildContext context) {
    var ct = _printersCt;
    return ValueListenableBuilder(
      valueListenable: ct.printers,
      builder: (context, value, child) {
        var printers = ct.printers.value;
        if (printers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        var zebraPrinters = filterPrintersName(printers, ["impzb", "impzm"]);
        var multifPrinters = filterPrintersName(printers, ["impxr", "impxm"]);
        return SingleChildScrollView(
          child: Column(
            children: [
              ExpansionTile(
                  title: Text(
                    'Multifuncionais',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    PrintersCards(
                      printers: multifPrinters,
                    ),
                  ]),
              ExpansionTile(
                  title: Text(
                    'Zebras',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    PrintersCards(printers: zebraPrinters),
                  ]),
            ],
          ),
        );
      },
    );
  }
}
