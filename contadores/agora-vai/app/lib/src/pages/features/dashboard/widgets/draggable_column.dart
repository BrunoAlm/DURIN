import 'package:app/main.dart';
import 'package:app/src/pages/features/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';

class DraggableColumn extends StatefulWidget {
  const DraggableColumn({super.key});

  @override
  State<DraggableColumn> createState() => _DraggableColumnState();
}

class _DraggableColumnState extends State<DraggableColumn> {
  final DashboardController dashCt = di();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(
          width: 100 + dashCt.columnWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
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
            onHorizontalDragStart: (details) => dashCt.onColumnDragStart(),
            onHorizontalDragUpdate: (details) =>
                dashCt.onColumnDragUpdate(details.delta.dx, screenWidth),
            onHorizontalDragEnd: (details) =>
                dashCt.onColumnDragEnd(screenWidth),
            child: Container(
              width: 2,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
