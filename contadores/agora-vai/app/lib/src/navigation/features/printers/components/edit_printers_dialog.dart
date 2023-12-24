import 'package:app/main.dart';
import 'package:app/src/navigation/features/printers/components/edit_printers_text_field.dart';
import 'package:app/src/navigation/features/printers/printers_controller.dart';
import 'package:app/src/navigation/features/printers/entities/printers_entity.dart';
import 'package:flutter/material.dart';

class EditPrintersDialog extends StatefulWidget {
  final PrintersEntity printer;
  const EditPrintersDialog({super.key, required this.printer});

  @override
  State<EditPrintersDialog> createState() => _EditPrintersDialogState();
}

class _EditPrintersDialogState extends State<EditPrintersDialog> {
  final PrintersController _printersCt = di();
  late TextEditingController pNameCT;
  late TextEditingController pModelCT;
  late TextEditingController pSelbCT;
  late TextEditingController pDepCT;
  late TextEditingController pStatusCT;
  late TextEditingController pTonerCT;

  @override
  void initState() {
    var printer = widget.printer;
    pNameCT = TextEditingController(text: printer.name);
    pModelCT = TextEditingController(text: printer.model);
    pSelbCT = TextEditingController(text: printer.selb);
    pDepCT = TextEditingController(text: printer.department);
    pStatusCT = TextEditingController(text: printer.status);
    pTonerCT = TextEditingController(text: printer.tonerLevel);
    super.initState();
  }

  @override
  void dispose() {
    pNameCT.dispose();
    pModelCT.dispose();
    pSelbCT.dispose();
    pDepCT.dispose();
    pStatusCT.dispose();
    pTonerCT.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Editar impressora'),
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EditPrintersTextField(ct: pNameCT, text: 'Nome'),
                const SizedBox(height: 10),
                EditPrintersTextField(ct: pModelCT, text: 'Modelo'),
                const SizedBox(height: 10),
                EditPrintersTextField(ct: pSelbCT, text: 'SELB'),
                const SizedBox(height: 10),
                EditPrintersTextField(ct: pDepCT, text: 'Departamento'),
                const SizedBox(height: 10),
                EditPrintersTextField(ct: pStatusCT, text: 'Status'),
                const SizedBox(height: 10),
                EditPrintersTextField(ct: pTonerCT, text: 'Nível de toner'),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  var printer = widget.printer;
                  PrintersEntity newPrinter = printer.copyWith(
                    name: pNameCT.text.trim(),
                    department: pDepCT.text.trim(),
                    tonerLevel: pTonerCT.text.trim(),
                    selb: pSelbCT.text.trim(),
                    model: pModelCT.text.trim(),
                    status: pStatusCT.text.trim(),
                  );
                  _printersCt.updatePrinters(newPrinter);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
                child: const Text('Confirmar'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
            ],
          ),
        )
      ],
    );
  }
}
