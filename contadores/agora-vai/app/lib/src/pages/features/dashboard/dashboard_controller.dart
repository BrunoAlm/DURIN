import 'package:app/src/core/helpers.dart';
import 'package:app/src/pages/features/printers/entities/counters_entity.dart';
import 'package:flutter/material.dart';

class DashboardController extends ChangeNotifier {
  late int counter;
  late double printerCost;

  final _listColumnsWidth = ValueNotifier(<double>[0, 0, 0, 0]);

  List<double> get columnsWidth => _listColumnsWidth.value;

  // setColumnsQty(int qty) {
  //   _listColumnsWidth.value = List.filled(qty, 0);
  // }

  init(List<CountersEntity?>? counters, String tipo) {
    counter = calculaContador(counters);
    printerCost = calculaCustoImpressora(tipo);
  }

  int calculaContador(List<CountersEntity?>? counters) {
    if (counters == null || counters.length < 2) {
      return 0; // Se for nulo ou não tiver 2 contadores coletados retorna 0
    }
    final latestCounter = counters.last?.counter ?? 0;
    final penultimateCounter = counters[counters.length - 2]?.counter ?? 0;

    return latestCounter - penultimateCounter;
  }

  double calculaCustoImpressora(String tipo) {
    late double valorPagExcedente;
    late double valorTotal;
    switch (tipo) {
      case 'etiqueta':
        valorPagExcedente =
            Helpers.dadosParaCalculo['valorPaginaExcedenteEtiquetas']!;
        valorTotal = valorPagExcedente +
            Helpers.dadosParaCalculo['valorImpressoraEtiquetas']!;
        break;
      case 'multifuncional':
        valorPagExcedente =
            Helpers.dadosParaCalculo['valorPaginaExcedenteMultifuncional']!;
        valorTotal = valorPagExcedente +
            Helpers.dadosParaCalculo['valorImpressoraMultifuncional']!;
        break;
      default:
        valorPagExcedente = 0;
    }

    return counter * valorPagExcedente + valorTotal;
  }

  void onColumnDragStart() {}

  void onColumnDragUpdate(double delta, int columnIndex, double tableWidth) {
    double sumWidths = _listColumnsWidth.value
        .fold(0.0, (previousValue, element) => previousValue + element);
    
    // Check if the column width is greater than or equal to 0
    // and if the sum of all widths is less than screenWidth
    if (_listColumnsWidth.value[columnIndex] >= 0 && sumWidths + delta <= tableWidth - _listColumnsWidth.value.length * 103) {
      _listColumnsWidth.value[columnIndex] += delta;
    }
    debugPrint('soma todas larguras: $sumWidths');
    debugPrint(
        "Largura coluna: ${_listColumnsWidth.value[columnIndex]} Tela: $tableWidth update");
    notifyListeners();
  }

  void onColumnDragEnd(double screenWidth, int columnIndex) {
    _listColumnsWidth.value[columnIndex] =
        _listColumnsWidth.value[columnIndex].clamp(1, screenWidth);
    notifyListeners();
    debugPrint(
        "Largura coluna: ${_listColumnsWidth.value[columnIndex]} Tela: $screenWidth end");
  }
}
