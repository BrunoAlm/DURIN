import 'package:flutter/material.dart';

class DraggableColumn extends StatefulWidget {
  final double columnWidth;
  final void Function(DragStartDetails)? onColumnDragStart;
  final void Function(DragUpdateDetails)? onColumnDragUpdate;
  final void Function(DragEndDetails)? onColumnDragEnd;
  final String header;
  final List<String> cells;

  const DraggableColumn({
    super.key,
    required this.columnWidth,
    required this.header,
    required this.cells,
    this.onColumnDragStart,
    this.onColumnDragUpdate,
    this.onColumnDragEnd,
  });

  @override
  State<DraggableColumn> createState() => _DraggableColumnState();
}

class _DraggableColumnState extends State<DraggableColumn> {
  double dragBarWidth = 2;
  double borderWidth = 2;
  Color borderColor = Colors.black26;
  Color dragBarColor = Colors.black26;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100 + widget.columnWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(width: borderWidth, color: borderColor),
                      top: BorderSide(width: borderWidth, color: borderColor),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      widget.header,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  widget.cells.length,
                  (index) => Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: borderWidth, color: borderColor),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: Text(widget.cells[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        MouseRegion(
            cursor: SystemMouseCursors.resizeColumn,
            onHover: (event) => setState(() {
                  dragBarWidth = 4;
                  dragBarColor = Colors.black54;
                }),
            onExit: (event) => setState(() {
                  dragBarWidth = 2;
                  dragBarColor = Colors.black26;
                }),
            child: GestureDetector(
              onHorizontalDragStart: widget.onColumnDragStart,
              onHorizontalDragUpdate: widget.onColumnDragUpdate,
              onHorizontalDragEnd: widget.onColumnDragEnd,
              child: Container(
                width: dragBarWidth,
                decoration: BoxDecoration(color: dragBarColor),
              ),
            ))
      ],
    );
  }
}
