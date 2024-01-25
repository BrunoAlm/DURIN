import 'package:flutter/widgets.dart';

class DraggableTable extends StatefulWidget {
  final List<String> headers;
  final List<List<String>> data;

  const DraggableTable({
    super.key,
    required this.headers,
    required this.data,
  });

  @override
  DraggableTableState createState() => DraggableTableState();
}

class DraggableTableState extends State<DraggableTable>
    with TickerProviderStateMixin {
  List<double> _columnWidths = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final screenWidth = MediaQuery.of(context).size.width;
    _columnWidths = List.generate(
        widget.headers.length, (index) => screenWidth / widget.headers.length);
  }

  @override
  Widget build(BuildContext context) {
    print(_columnWidths);
    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // Linha de cabeçalho
          TableRow(
            children: [
              for (int i = 0; i < widget.headers.length; i++)
                GestureDetector(
                  onHorizontalDragStart: (details) {
                    _onColumnDragStart(i);
                    print(" saporra $_columnWidths");
                  },
                  onHorizontalDragUpdate: (details) =>
                      _onColumnDragUpdate(i, details.delta.dx),
                  onHorizontalDragEnd: (details) => _onColumnDragEnd(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    width: _columnWidths[i],
                    child: Text(
                      widget.headers[i],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
      
          // Linhas de dados
          for (List<String> row in widget.data)
            TableRow(
              key: ValueKey(row),
              children: [
                for (int i = 0;
                    i < widget.headers.length;
                    i++) // Use widget.headers.length como referência
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    width: _columnWidths[i],
                    child: Text(row[i]),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  void _onColumnDragStart(int columnIndex) {
    print('start');
    // setState(() {
    //   _columnWidths[columnIndex] -= 10;
    // });
  }

  void _onColumnDragUpdate(int columnIndex, double delta) {
    print('update');
    setState(() {
      _columnWidths[columnIndex] += delta;
    });
  }

  void _onColumnDragEnd(int columnIndex) {
    print('end');
    // setState(() {
    //   _columnWidths[columnIndex] = _columnWidths[columnIndex]
    //       .clamp(10, MediaQuery.of(context).size.width);
    // });
  }
}
