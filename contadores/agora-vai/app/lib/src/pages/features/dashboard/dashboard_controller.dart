import 'package:app/src/core/helpers.dart';
import 'package:app/src/pages/features/printers/entities/counters_entity.dart';
import 'package:flutter/material.dart';

class DashboardController extends ChangeNotifier {
  late int counter;
  late double printerCost;

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
}
