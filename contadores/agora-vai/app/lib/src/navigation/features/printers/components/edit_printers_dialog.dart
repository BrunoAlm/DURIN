import 'package:flutter/material.dart';

class EditPrintersDialog extends StatefulWidget {
  const EditPrintersDialog({super.key});

  @override
  State<EditPrintersDialog> createState() => _EditPrintersDialogState();
}

class _EditPrintersDialogState extends State<EditPrintersDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Editar impressora'),
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            child: TextFormField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
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
