import 'package:app/src/core/helpers.dart';
import 'package:app/src/navigation/features/printers/components/printers_cards.dart';
import 'package:app/src/navigation/features/printers/entities/printers_entity.dart';
import 'package:flutter/material.dart';

class ListPrintersPage extends StatefulWidget {
  final String title;
  final List<PrintersEntity> zebras;
  final List<PrintersEntity> multifuns;

  const ListPrintersPage({
    super.key,
    required this.title,
    required this.zebras,
    required this.multifuns,
  });

  @override
  State<ListPrintersPage> createState() => _ListPrintersPageState();
}

class _ListPrintersPageState extends State<ListPrintersPage> {
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Multifuncionais', style: Helpers.titleStyle),
              PrintersCards(
                printers: filterPrintersName(
                  widget.multifuns,
                  widget.title == "Araquari" ? ["impxr"] : ["impxm"],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Zebras', style: Helpers.titleStyle),
              PrintersCards(
                  printers: filterPrintersName(
                widget.zebras,
                widget.title == "Araquari" ? ["impzb"] : ["impzm"],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
