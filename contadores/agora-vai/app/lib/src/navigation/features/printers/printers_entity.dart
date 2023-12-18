class PrintersEntity {
  final int id;
  final String name;
  final String ip;
  final String selb;
  final String department;
  final String type;
  final int tonerLevel;
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
  final int id;
  final int impressoraId;
  final int counter;
  final DateTime collectedDate;

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
      collectedDate: formatDate(map['data_registro']),
    );
  }

  static DateTime formatDate(String dateString) {
    RegExp regex = RegExp(r'(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})');
    RegExpMatch? match = regex.firstMatch(dateString ?? '');

    if (match != null) {
      int year = int.parse(match.group(1)!);
      int month = int.parse(match.group(2)!);
      int day = int.parse(match.group(3)!);
      int hour = int.parse(match.group(4)!);
      int minute = int.parse(match.group(5)!);
      int second = int.parse(match.group(6)!);

      return DateTime(year, month, day, hour, minute, second);
    } else {
      throw Exception('Invalid date format');
    }
  }
}
