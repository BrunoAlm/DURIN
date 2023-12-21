import 'dart:developer';
import 'dart:typed_data';
import 'package:app/main.dart';
import 'package:app/src/navigation/features/printers/printers_entity.dart';
import 'package:app/src/navigation/features/printers/printers_repository.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;

class PrintersController extends ChangeNotifier {
  final PrintersRepository _printersRepository = di();

  final printers = ValueNotifier(<PrintersEntity>[]);
  List<bool> _selectedPrinters = [];
  List<bool> get isPrinterSelected => _selectedPrinters;

  set selectPrinter(int index) {
    _selectedPrinters[index] = !_selectedPrinters[index];
    notifyListeners();
  }

  void init() async {
    try {
      printers.value = await _printersRepository.list();
      _selectedPrinters = List.filled(printers.value.length, false);
    } on DioException catch (e) {
      log(
        'Response: ${e.response}\n'
        'Error: ${e.error}\n'
        'Message: ${e.message}\n'
        'StackTrace: ${e.stackTrace}',
        name: 'printersRepository.list',
      );
    }
  }

  void updatePrinters(List<int> printersId) {
    var body = {'printers_id': printersId};
    _printersRepository.updatePrinters(body);
  }

  Uint8List _generateCSV(List<PrintersEntity> printers) {
    List<List<dynamic>> printerData = [];

    printerData.add([
      'Nome',
      'IP',
      'Departamento',
      'Contador Anterior',
      'Contador Atual',
      'Data de Coleta'
    ]);

    for (var printer in printers) {
      printerData.add([
        printer.name,
        printer.ip,
        printer.department,
        printer.counters.elementAt(printer.counters.length - 2).counter,
        printer.counters.last.counter,
        printer.counters.last.collectedDate,
      ]);
    }

    final csvData =
        const ListToCsvConverter(fieldDelimiter: ',').convert(printerData);

    // Converte os dados do CSV diretamente para Uint8List
    final encodedData = Uint8List.fromList(csvData.codeUnits);

    return encodedData; // Retorna os dados como Uint8List
  }

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

  void generateReport(String fileName) {
    List<PrintersEntity> selectedPrinters = [];
    var allPrinters = printers.value;
    for (var i = 0; i < allPrinters.length; i++) {
      if (isPrinterSelected[i]) {
        selectedPrinters.add(allPrinters[i]);
      }
    }
    Uint8List csv = _generateCSV(selectedPrinters); // Alterado para Uint8List
    // _downloadFile(csv, fileName);
  }
}
