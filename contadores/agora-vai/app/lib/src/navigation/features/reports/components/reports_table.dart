import 'package:app/src/navigation/features/reports/reports_controller.dart';
import 'package:app/src/navigation/features/printers/printers_entity.dart';
import 'package:flutter/material.dart';

class ReportsTable extends StatefulWidget {
  final List<PrintersEntity> printers;
  final ReportsController ct;

  const ReportsTable({
    super.key,
    required this.printers,
    required this.ct,
  });

  @override
  State<ReportsTable> createState() => _ReportsTableState();
}

class _ReportsTableState extends State<ReportsTable> {
  @override
  Widget build(BuildContext context) {
    var printers = widget.printers;
    var ct = widget.ct;
    return SingleChildScrollView(
      child: AnimatedBuilder(
          animation: ct,
          builder: (context, value) {
            var columnTextStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold);
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
                  var selected = ct.isSelected[index];
                  var date = printer.counters.last.collectedDate;
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
                        Text(printer.counters.last.counter.toString()),
                      ),
                      DataCell(
                        Text('${date.hour}:${date.minute}  ${date.day}/${date.month}/${date.year}')
                      ),
                    ],
                    selected: selected,
                    onSelectChanged: (value) {
                      ct.selectPrinter = index;
                    },
                  );
                },
              ),
            );
          }),
    );
  }
}
