import 'package:app/src/navigation/features/printers/printers_controller.dart';
import 'package:flutter/material.dart';

class PrintersPage extends StatefulWidget {
  const PrintersPage({Key? key}) : super(key: key);

  @override
  State<PrintersPage> createState() => _PrintersPageState();
}

class _PrintersPageState extends State<PrintersPage> {
  final PrintersController _printersCt = PrintersController();

  @override
  void initState() {
    _printersCt.addListener(() {
      setState(() {});
    });
    _printersCt.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: _printersCt.printers,
        builder: (context, value, child) {
          var printers = _printersCt.printers.value;
          if (printers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: AnimatedBuilder(
                animation: _printersCt,
                builder: (context, value) {
                  return DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('Impressoras'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      printers.length,
                      (index) {
                        var printer = printers[index];
                        var selected = _printersCt.isSelected[index];
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(printer.name),
                            ),
                          ],
                          selected: selected,
                          onSelectChanged: (value) {
                            _printersCt.selectPrinter = index;
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
