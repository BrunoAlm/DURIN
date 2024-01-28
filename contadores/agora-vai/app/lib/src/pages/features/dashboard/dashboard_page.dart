import 'dart:math';

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

class _DashboardPageState extends State<DashboardPage> {
  final PrintersController printersCt = di();
  final DashboardController dashCt = di();
  int columnsQty = 4;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    double tableWidth = MediaQuery.of(context).size.width;
    GlobalKey tableKey = GlobalKey(debugLabel: 'Tabela');
    return AnimatedBuilder(
      animation: dashCt,
      builder: (context, child) => Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            key: tableKey,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              columnsQty,
              (index) {
                return DraggableColumn(
                  columnWidth: dashCt.columnsWidth[index],
                  onColumnDragUpdate: (update) {
                    double tableWidth = tableKey.currentContext!.size!.width;
                    double delta = update.delta.dx;
                    dashCt.onColumnDragUpdate(delta, index, tableWidth);
                  },
                  onColumnDragEnd: (end) =>
                      dashCt.onColumnDragEnd(tableWidth, index),
                  header: 'Column ${index + 1}',
                  cells:
                      List.generate(14, (_) => random.nextInt(1000).toString()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
