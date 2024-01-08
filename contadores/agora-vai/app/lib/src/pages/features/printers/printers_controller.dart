import 'dart:developer';
import 'package:app/main.dart';
import 'package:app/src/pages/features/printers/entities/printers_entity.dart';
import 'package:app/src/pages/features/printers/printers_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class PrintersController extends ChangeNotifier {
  final PrintersRepository _printersRepository = di();
  final printers = ValueNotifier(<PrintersEntity>[]);
  
  Future init() async {
    printers.value = await listPrinters();
  }

  Future<List<PrintersEntity>> listPrinters() async {
    List<PrintersEntity> printers = [];
    try {
      printers = await _printersRepository.list();
    } on DioException catch (e) {
      log(
        'Response: ${e.response}\n'
        'Error: ${e.error}\n'
        'Message: ${e.message}\n'
        'StackTrace: ${e.stackTrace}',
        name: 'printersController.listPrinters',
      );
    }
    return printers;
  }

  void updateCounters(List<int> printersId) {
    var body = {'printers_id': printersId};
    try {
      _printersRepository.updateCounters(body);
    } on DioException catch (e) {
      log(
        'Response: ${e.response}\n'
        'Error: ${e.error}\n'
        'Message: ${e.message}\n'
        'StackTrace: ${e.stackTrace}',
        name: 'printersController.updateCounters',
      );
    }
  }

  void updatePrinters(PrintersEntity printer) {
    var body = PrintersEntity.toMap(printer);
    try {
      _printersRepository.updatePrinter(body);
    } on DioException catch (e) {
      log(
        'Response: ${e.response}\n'
        'Error: ${e.error}\n'
        'Message: ${e.message}\n'
        'StackTrace: ${e.stackTrace}',
        name: 'printersController.updateCounters',
      );
    }
    notifyListeners();
  }
  
}
