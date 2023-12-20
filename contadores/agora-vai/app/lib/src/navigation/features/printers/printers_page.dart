import 'package:app/main.dart';
import 'package:app/src/navigation/features/printers/printers_controller.dart';
import 'package:flutter/material.dart';

class PrintersPage extends StatefulWidget {
  const PrintersPage({Key? key}) : super(key: key);


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
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox()
          );
        },
      ),
    );
  }
}
