import 'package:app/src/pages/features/printers/entities/counters_entity.dart';

class PrintersEntity {
  final int id;
  final String name;
  final String ip;
  final String selb;
  final String department;
  final String type;
  final String tonerLevel;
  final String model;
  final String status;
  final List<CountersEntity?>? counters;

  PrintersEntity({
    required this.id,
    required this.name,
    required this.ip,
    required this.selb,
    required this.department,
    required this.type,
    required this.tonerLevel,
    required this.model,
    required this.status,
    this.counters,
  });

  static Map<String, dynamic> toMap(PrintersEntity printer) {
    return <String, dynamic>{
      'impressora_id': printer.id,
      'nome': printer.name,
      'ip': printer.ip,
      'selb': printer.selb,
      'setor': printer.department,
      'tipo': printer.type,
      'nivel_toner': printer.tonerLevel,
      'modelo': printer.model,
      'status': printer.status,
    };
  }

  factory PrintersEntity.fromMap(Map<String, dynamic> map) {
    return PrintersEntity(
      id: map['id'],
      name: map['nome'],
      ip: map['ip'],
      selb: map['selb'],
      department: map['setor'],
      type: map['tipo'],
      tonerLevel: map['nivel_toner'].toString(),
      model: map['modelo'],
      status: map['status'],
      counters: (map['contadores'] as List)
          .map((e) => CountersEntity.fromMap(e))
          .toList(),
    );
  }

  PrintersEntity copyWith({
    String? name,
    String? ip,
    String? selb,
    String? department,
    String? type,
    String? tonerLevel,
    String? model,
    String? status,
  }) =>
      PrintersEntity(
        id: id,
        name: name ?? this.name,
        ip: ip ?? this.ip,
        selb: selb ?? this.selb,
        department: department ?? this.department,
        type: type ?? this.type,
        tonerLevel: tonerLevel ?? this.tonerLevel,
        model: model ?? this.model,
        status: status ?? this.status,
        counters: counters,
      );
}
