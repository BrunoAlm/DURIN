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
                  label: Text('', style: columnTextStyle),
                ),
                DataColumn(
                  label: Text('Nome', style: columnTextStyle),
                ),
                DataColumn(
                  label: Text('SELB', style: columnTextStyle),
                ),
                DataColumn(
                  label: Text('IP', style: columnTextStyle),
                ),
                DataColumn(
                  label: Text('Local', style: columnTextStyle),
                ),
                DataColumn(
                  label: Text('Empresa', style: columnTextStyle),
                ),
                DataColumn(
                  label: Text('Contador Anterior', style: columnTextStyle),
                ),
                DataColumn(
                  label: Text('Contador Atual', style: columnTextStyle),
                ),
                DataColumn(
                  label: Text('Data ultima coleta', style: columnTextStyle),
                ),
              ],
              rows: List<DataRow>.generate(
                printers.length,
                (index) {
                  PrintersEntity printer = printers[index];
                  bool selected = ct.isPrinterSelected[index];

                  DateTime date;
                  if (printer.counters!.isNotEmpty) {
                    date = printer.counters!.last!.collectedDate;
                  } else {
                    date = DateTime(0);
                  }

                  int latestCounter = printer.counters?.isNotEmpty == true
                      ? printer.counters!.last?.counter ?? 0
                      : 0;

                  int penultimateCounter = (printer.counters?.length ?? 0) >= 2
                      ? printer.counters![printer.counters!.length - 2]
                              ?.counter ??
                          0
                      : 0;

                  return DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(printer.id.toString()),
                      ),
                      DataCell(
                        Text(printer.name),
                      ),
                      DataCell(
                        Text(printer.selb),
                      ),
                      DataCell(
                        Text(printer.ip),
                      ),
                      DataCell(
                        Text(printer.department),
                      ),
                      DataCell(
                        Text(printer.company),
                      ),
                      DataCell(
                        Text(penultimateCounter.toString()),
                      ),
                      DataCell(
                        Text(latestCounter.toString()),
                      ),
                      DataCell(
                        Text(date == DateTime(0)
                            ? 'Não coletado'
                            : '${date.hour}:${date.minute}  ${date.day}/${date.month}/${date.year}'),
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
