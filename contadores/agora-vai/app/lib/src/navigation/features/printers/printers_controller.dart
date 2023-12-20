import 'dart:convert';
import 'dart:developer';
import 'package:app/main.dart';
import 'package:app/src/navigation/features/printers/printers_entity.dart';
import 'package:app/src/navigation/features/printers/printers_repository.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

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

  String _generateCSV(List<PrintersEntity> printers) {
    List<List<dynamic>> printerData = [];

    printerData
        .add(['Nome', 'IP', 'Departamento', 'Contador', 'Data de Coleta']);

    for (var printer in printers) {
      printerData.add([
        printer.name,
        printer.ip,
        printer.department,
        printer.counters.last.counter,
        printer.counters.last.collectedDate,
      ]);
    }

    const csvConverter = ListToCsvConverter();
    final csvData = csvConverter.convert(printerData);

    return csvData;
  }

  void _downloadFile(String content, String fileName) {
    final encodedContent = utf8.encode(content);
    final blob = html.Blob([encodedContent]);

    // Cria a URL do arquivo
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Realizar o download
    html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();

    // Libera a URL após o download
    html.Url.revokeObjectUrl(url);
  }

  void generateReport(String fileName) {
    List<PrintersEntity> selectedPrinters = [];
    var allPrinters = printers.value;
    for (var i = 0; i < allPrinters.length; i++) {
      if (isPrinterSelected[i]) {
        selectedPrinters.add(allPrinters[i]);
      }
    }
    String csv = _generateCSV(selectedPrinters);
    _downloadFile(csv, fileName);
  }
}
