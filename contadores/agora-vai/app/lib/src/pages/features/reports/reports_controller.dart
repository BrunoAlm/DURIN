import 'package:app/src/pages/features/printers/entities/printers_entity.dart';
import 'package:flutter/material.dart';
// import 'dart:typed_data';
// import 'package:csv/csv.dart';
// import 'dart:html' as html;

class ReportsController extends ChangeNotifier {
  ValueNotifier<List<bool>> selectedPrinters = ValueNotifier(<bool>[]);

  List<bool> get isPrinterSelected => selectedPrinters.value;

  set selectPrinter(int index) {
    selectedPrinters.value[index] = !selectedPrinters.value[index];
    notifyListeners();
  }

  Future init(int printersQty) async {
    selectedPrinters.value = List.filled(printersQty, false);
  }

  // Uint8List _generateCSV(List<PrintersEntity> printers) {
  //   List<List<dynamic>> printerData = [];

  //   printerData.add([
  //     'Nome',
  //     'SELB',
  //     'IP',
  //     'Departamento',
  //     'Contador Anterior',
  //     'Contador Atual',
  //     'Ultima Coleta'
  //   ]);

  //   for (var printer in printers) {
  //     printerData.add([
  //       printer.name,
  //       printer.selb,
  //       printer.ip,
  //       printer.department,
  //       printer.counters!.elementAt(printer.counters!.length - 2)!.counter,
  //       printer.counters!.last!.counter,
  //       printer.counters!.last!.collectedDate,
  //     ]);
  //   }

  //   final csvData =
  //       const ListToCsvConverter(fieldDelimiter: ',').convert(printerData);

  //   // Converte os dados do CSV diretamente para Uint8List
  //   final encodedData = Uint8List.fromList(csvData.codeUnits);

  //   return encodedData; // Retorna os dados como Uint8List
  // }

  // void _downloadFile(Uint8List content, String fileName) {
  //   final blob = html.Blob([content]);

  //   // Cria a URL do arquivo
  //   final url = html.Url.createObjectUrlFromBlob(blob);

  //   // Realiza o download
  //   html.AnchorElement(href: url)
  //     ..setAttribute('download', fileName)
  //     ..click();

  //   // Libera a URL após o download
  //   html.Url.revokeObjectUrl(url);
  // }

  void generateReport(String fileName, List<PrintersEntity> printers) {
    List<PrintersEntity> selectedPrinters = [];
    for (var i = 0; i < printers.length; i++) {
      if (this.selectedPrinters.value[i]) {
        selectedPrinters.add(printers[i]);
      }
    }
    // Uint8List csv = _generateCSV(selectedPrinters); // Alterado para Uint8List
    // _downloadFile(csv, fileName);
  }
}
