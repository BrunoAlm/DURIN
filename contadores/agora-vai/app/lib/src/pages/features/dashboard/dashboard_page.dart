import 'package:app/main.dart';
import 'package:app/src/pages/features/dashboard/dashboard_controller.dart';
import 'package:app/src/pages/features/dashboard/widgets/draggble_table.dart';
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
  double _blockWidth = 0;
  var rowKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Flexible(
          child: Row(
            key: rowKey,
            children: [
              Container(
                width: 100 + _blockWidth,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 238, 238),
                    border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        decoration:
                            const BoxDecoration(border: Border(bottom: BorderSide())),
                        child: const Text('Header1')),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        10,
                        (index) => Container(
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide())),
                            child: Text('$index')),
                      ),
                    )
                  ],
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.resizeColumn,
                child: GestureDetector(
                  onHorizontalDragStart: (details) {
                    _onColumnDragStart();
                  },
                  onHorizontalDragUpdate: (details) =>
                      _onColumnDragUpdate(details.delta.dx, screenWidth),
                  onHorizontalDragEnd: (details) =>
                      _onColumnDragEnd(screenWidth),
                  child: Container(
                    width: 2,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
             Container(
                width: 100 + _blockWidth,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 238, 238),
                    border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        decoration:
                            const BoxDecoration(border: Border(bottom: BorderSide())),
                        child: const Text('Header2')),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        10,
                        (index) => Container(
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide())),
                            child: Text('$index')),
                      ),
                    )
                  ],
                ),
              ),
             Container(
                width: 100 + _blockWidth,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 238, 238),
                    border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        decoration:
                            const BoxDecoration(border: Border(bottom: BorderSide())),
                        child: const Text('Header3')),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        10,
                        (index) => Container(
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide())),
                            child: Text('$index')),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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

  void _onColumnDragStart() {
    // setState(() {
    //   _blockWidth -= 10;
    // });
  }

  void _onColumnDragUpdate(double delta, double screenWidth) {
    print(rowKey);
    if (_blockWidth >= 0 && _blockWidth <= screenWidth - 200) {
      print("Bloco: $_blockWidth Tela: $screenWidth");
      setState(() {
        _blockWidth += delta;
      });
    }
  }

  void _onColumnDragEnd(double screenWidth) {
    setState(() {
      _blockWidth = _blockWidth.clamp(10, screenWidth);
      _blockWidth -= 1;
    });
  }
}
