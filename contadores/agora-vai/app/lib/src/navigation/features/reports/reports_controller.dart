import 'dart:developer';
import 'package:app/src/navigation/features/printers/printers_entity.dart';
import 'package:app/src/navigation/features/printers/printers_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReportsController extends ChangeNotifier {
  final PrintersRepository _printersRepository = PrintersRepositoryV1();
  final printers = ValueNotifier(<PrintersEntity>[]);
  List<bool> _selected = [];

  List<bool> get isSelected => _selected;

  set selectPrinter(int index) {
    _selected[index] = !_selected[index];
    notifyListeners();
  }

  void init() async {
    try {
      printers.value = await _printersRepository.list();
      _selected =
          List<bool>.generate(printers.value.length, (int index) => false);
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
}
