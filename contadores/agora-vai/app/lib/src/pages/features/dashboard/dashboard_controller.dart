import 'package:app/src/core/helpers.dart';
import 'package:app/src/pages/features/printers/entities/counters_entity.dart';
import 'package:flutter/material.dart';

class DashboardController extends ChangeNotifier {
  late int counter;
  late double printerCost;

  final ValueNotifier<double> lColumnWidth = ValueNotifier(0);

  double get columnWidth => lColumnWidth.value;

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

  void onColumnDragUpdate(double delta, double screenWidth) {
    if (lColumnWidth.value >= 0 && lColumnWidth.value <= screenWidth - 200) {
      print("Bloco: $lColumnWidth.value Tela: $screenWidth");
      lColumnWidth.value += delta;
    }
  }

  void onColumnDragEnd(double screenWidth) {
    lColumnWidth.value = lColumnWidth.value.clamp(10, screenWidth);
    // _columnWidth.value -= 1;
  }
}
