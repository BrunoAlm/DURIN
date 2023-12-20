import 'package:app/src/navigation/features/printers/counters_entity.dart';

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
  final List<CountersEntity> counters;

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
    required this.counters,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': name,
      'ip': ip,
      'selb': selb,
      'setor': department,
      'tipo': type,
      'nivel_toner': tonerLevel,
      'modelo': model,
      'status': status,
      'contadores': counters.map((e) => e.toMap() )
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
}
