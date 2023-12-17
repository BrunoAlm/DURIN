import 'package:app/src/core/api_service.dart';
import 'package:app/src/navigation/features/printers/printers_entity.dart';

abstract interface class PrintersRepository {
  Future<List<PrintersEntity>> list();
}

class PrintersRepositoryV1 implements PrintersRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<List<PrintersEntity>> list() async {
    var result = await _apiService.get(path: "/impressoras");
    return (result as List).map((e) => PrintersEntity.fromMap(e)).toList();
  }
}
