import 'package:app/main.dart';
import 'package:app/src/pages/features/dashboard/dashboard_controller.dart';
import 'package:app/src/pages/features/dashboard/widgets/draggable_column.dart';
import 'package:app/src/pages/features/printers/printers_controller.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  final PrintersController printersCt = di();
  final DashboardController dashCt = di();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dashCt.lColumnWidth,
      builder: (context, _, __) {
        return Container(
          decoration: BoxDecoration(border: Border.all()),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DraggableColumn(),
              DraggableColumn(),
              DraggableColumn(),
            ],
          ),
        );
      }
    );
    // final headers = ["Nome", "IP", "Contador Atual"];
    // final data = [
    //   ["impxr001", "10.0.3.1", "123123"],
    //   ["impxr002", "10.0.3.2", "1231234"],
    //   ["impxr003", "10.0.3.3", "12312345"],
    // ];
    // return Padding(
    //   padding: const EdgeInsets.all(18.0),
    //   child: DraggableTable(headers: headers, data: data),
    // );
    // return

    // ValueListenableBuilder(
    //   valueListenable: printersCt.printers,
    //   builder: (context, printers, child) {
    //     if (printers.isEmpty) {
    //       return const Center(child: CircularProgressIndicator());
    //     }

    // return GridView.builder(
    //   // itemCount: Helpers.branchesList.length,
    //   itemCount: printers.length,
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 8),
    //   shrinkWrap: true,
    //   scrollDirection: Axis.vertical,
    //   itemBuilder: (context, index) {
    //     dashCt.init(printers[index].counters, printers[index].type);
    //     int counter = dashCt.counter;
    //     double printerCost = dashCt.printerCost;
    //     // String branch = Helpers.branchesList[index];
    //     return Card(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text("Nome: ${printers[index].name}"),
    //           Text("Quantidade impressa: $counter páginas/inches"),
    //           Text("Custo: R\$${printerCost.toStringAsFixed(2)}"),
    //         ],
    //       ),
    //     );
    //   },
    // );
    // },
    // );
  }

}
