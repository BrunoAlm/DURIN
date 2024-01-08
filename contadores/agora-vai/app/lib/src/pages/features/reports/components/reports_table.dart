import 'package:app/src/pages/features/printers/entities/printers_entity.dart';
import 'package:app/src/pages/features/reports/reports_controller.dart';
import 'package:flutter/material.dart';

class ReportsTable extends StatefulWidget {
  final List<PrintersEntity> printers;
  final ReportsController reportsCt;

  const ReportsTable({
    super.key,
    required this.printers,
    required this.reportsCt,
  });

  @override
  State<ReportsTable> createState() => _ReportsTableState();
}

class _ReportsTableState extends State<ReportsTable> {
  @override
  void initState() {
    widget.reportsCt.init(widget.printers.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var printers = widget.printers;
    var ct = widget.reportsCt;

    var columnTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.bold);
    return SingleChildScrollView(
      child: AnimatedBuilder(
        animation: ct,
        builder: (context, widget) {
          return DataTable(
            columns: <DataColumn>[
              DataColumn(
                label: Text('Impressoras', style: columnTextStyle),
              ),
              DataColumn(
                label: Text('IP', style: columnTextStyle),
              ),
              DataColumn(
                label: Text('Local', style: columnTextStyle),
              ),
              DataColumn(
                label: Text('Contador Anterior', style: columnTextStyle),
              ),
              DataColumn(
                label: Text('Contador Atual', style: columnTextStyle),
              ),
              DataColumn(
                label: Text('Data de coleta', style: columnTextStyle),
              ),
            ],
            rows: List<DataRow>.generate(
              printers.length,
              (index) {
                var printer = printers[index];
                var selected = ct.isPrinterSelected[index];
                var date = printer.counters!.last!.collectedDate;
                var latestCounter = printer.counters!.last!.counter;
                var penultimateCounter = printer.counters!
                    .elementAt(printer.counters!.length - 2)!
                    .counter;
                return DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text(printer.name),
                    ),
                    DataCell(
                      Text(printer.ip),
                    ),
                    DataCell(
                      Text(printer.department),
                    ),
                    DataCell(
                      Text(penultimateCounter.toString()),
                    ),
                    DataCell(
                      Text(latestCounter.toString()),
                    ),
                    DataCell(Text(
                        '${date.hour}:${date.minute}  ${date.day}/${date.month}/${date.year}')),
                  ],
                  selected: selected,
                  onSelectChanged: (value) {
                    ct.selectPrinter = index;
                  },
                );
              },
            ),
          );
        }
      ),
    );
  }
}
