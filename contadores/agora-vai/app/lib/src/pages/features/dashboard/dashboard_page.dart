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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: dashCt,
      builder: (context, child) => Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
            children: List.generate(
          columnsQty,
          (index) {
            // dashCt.setColumnsQty(columnsQty);
            return DraggableColumn(
              columnWidth: dashCt.columnsWidth[index],
              onColumnDragUpdate: (update) {
                double delta = update.delta.dx;
                dashCt.onColumnDragUpdate(delta, index, screenWidth);
              },
              onColumnDragEnd: (end) =>
                  dashCt.onColumnDragEnd(screenWidth, index),
              header: 'Column ${index + 1}',
              cells: List.generate(10, (index) => index.toString()),
            );
          },
        )),
      ),
    );
  }
}
