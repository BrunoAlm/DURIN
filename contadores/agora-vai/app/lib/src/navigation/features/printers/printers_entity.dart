class PrintersEntity {
  int id;
  String name;
  String ip;
  String selb;
  String department;
  String type;
  int tonerLevel;
  String model;
  String status;
  List<CountersEntity> counters;

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
      'contadores': counters.map((e) => e.toMap())
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
      tonerLevel: map['nivel_toner'],
      model: map['modelo'],
      status: map['status'],
      counters: (map['contadores'] as List)
          .map((e) => CountersEntity.fromMap(e))
          .toList(),
    );
  }

  // List<CountersEntity> convertCounters(Map<String, dynamic> map) {
  //   var result = CountersEntity.fromMap(map);
  //   return result;
  // }
}

class CountersEntity {
  int id;
  int impressoraId;
  int counter;
  String collectedDate;

  CountersEntity({
    required this.id,
    required this.impressoraId,
    required this.counter,
    required this.collectedDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'impressora_id': impressoraId,
      'contador': counter,
      'data_registro': collectedDate,
    };
  }

  factory CountersEntity.fromMap(Map<String, dynamic> map) {
    return CountersEntity(
      id: map['id'],
      impressoraId: map['impressora_id'],
      counter: map['contador'],
      collectedDate: map['data_registro'],
    );
  }
}
