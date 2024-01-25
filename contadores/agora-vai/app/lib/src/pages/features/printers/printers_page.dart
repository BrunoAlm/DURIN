import 'package:app/main.dart';
import 'package:app/src/core/helpers.dart';
import 'package:app/src/pages/features/printers/components/branches_card.dart';
import 'package:app/src/pages/features/printers/components/list_printers_page.dart';
import 'package:app/src/pages/features/printers/printers_controller.dart';
import 'package:flutter/material.dart';

class PrintersPage extends StatefulWidget {
  const PrintersPage({super.key});

  @override
  State<PrintersPage> createState() => _PrintersPageState();
}

class _PrintersPageState extends State<PrintersPage> {
  final PrintersController _printersCt = di();

  @override
  Widget build(BuildContext context) {
    var ct = _printersCt;
    return Center(
      child: ValueListenableBuilder(
        valueListenable: ct.printers,
        builder: (context, value, child) {
          var printers = ct.printers.value;
          if (printers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          var zebras = printers.where((p) => p.type == 'etiqueta').toList();
          var multifuns =
              printers.where((p) => p.type == 'multifuncional').toList();
          return ListView.builder(
            itemCount: Helpers.branchesList.length,
            // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String branch = Helpers.branchesList[index];
              return Center(
                child: BranchesCard(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ListPrintersPage(
                          title: branch,
                          multifuns: multifuns,
                          zebras: zebras,
                        ),
                      ),
                    );
                  },
                  title: branch,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
