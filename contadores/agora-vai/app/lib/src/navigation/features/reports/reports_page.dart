import 'package:app/main.dart';
import 'package:app/src/navigation/features/printers/printers_controller.dart';
import 'package:app/src/navigation/features/reports/components/reports_table.dart';
import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final PrintersController _reportsCt = di();

  @override
  void initState() {
    _reportsCt.init();
    super.initState();
  }

  @override
  void dispose() {
    _reportsCt.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerar relatório'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () => _reportsCt.generateReport('report.csv'),
              icon: const Icon(Icons.get_app_outlined),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: _reportsCt.printers,
            builder: (context, value, child) {
              var printers = _reportsCt.printers.value;
              if (printers.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReportsTable(printers: printers, ct: _reportsCt),
              );
            },
          ),
        ),
      ),
    );
  }
}
