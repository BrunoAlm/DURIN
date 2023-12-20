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
      counter: convertToInt(map['contador']) ?? 0,
      collectedDate: formatDate(map['data_registro']),
    );
  }

  static DateTime formatDate(String dateString) {
    RegExp regex = RegExp(r'(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})');
    RegExpMatch? match = regex.firstMatch(dateString);

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

  static int? convertToInt(String value) {
    // Verifica se a string possui vírgulas
    if (value.contains(',')) {
      // Remove todas as vírgulas do valor
      String cleanedValue = value.replaceAll(',', '');

      // Converte para inteiro
      return int.tryParse(cleanedValue) ??
          0; // Retorna 0 se não puder converter
    } else {
      // Se não houver vírgulas, tenta converter diretamente
      return int.tryParse(value) ?? 0; // Retorna 0 se não puder converter
    }
  }
}
