import 'package:flutter/material.dart';
import 'package:app/src/navigation/features/printers/printers_entity.dart';

class PrintersCards extends StatefulWidget {
  final List<PrintersEntity> printers;
  const PrintersCards({super.key, required this.printers});

  @override
  State<PrintersCards> createState() => _PrintersCardsState();
}

class _PrintersCardsState extends State<PrintersCards> {
  void editPrinter(PrintersEntity printer) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
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
                    child: const Text('Confirmar')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar')),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var printers = widget.printers;
    return Wrap(
      children: List<Widget>.generate(
        printers.length,
        (index) {
          var printer = printers[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 18.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        printer.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
                      CircleAvatar(
                        child: IconButton(
                          onPressed: () => editPrinter(printer),
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                  Text(printer.department),
                  Text(printer.ip),
                  Text(printer.model),
                  Text(printer.selb),
                  Text(printer.status),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
