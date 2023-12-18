import 'package:app/src/navigation/features/reports/reports_controller.dart';
import 'package:app/src/navigation/features/reports/components/reports_table.dart';
import 'package:flutter/material.dart';

class PrintersPage extends StatefulWidget {
  const PrintersPage({Key? key}) : super(key: key);

  @override
  State<PrintersPage> createState() => _PrintersPageState();
}

class _PrintersPageState extends State<PrintersPage> {
  final ReportsController _printersCt = ReportsController();

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
            child: SizedBox()
          );
        },
      ),
    );
  }
}
