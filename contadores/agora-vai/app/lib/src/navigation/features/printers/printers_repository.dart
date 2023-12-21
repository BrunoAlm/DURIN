import 'package:app/src/core/api_service.dart';
import 'package:app/src/navigation/features/printers/printers_entity.dart';

abstract interface class PrintersRepository {
  Future<List<PrintersEntity>> list();
  Future<void> updateCounters(Map<String, dynamic> body);
  Future<void> updatePrinter(Map<String, dynamic> body);
}

class PrintersRepositoryV1 implements PrintersRepository {
  final ApiService _apiService;
  PrintersRepositoryV1(this._apiService);

  @override
  Future<List<PrintersEntity>> list() async {
    var result = await _apiService.get(path: "/api/impressoras");
    return (result as List).map((e) => PrintersEntity.fromMap(e)).toList();
  }

  @override
  Future<void> updateCounters(Map<String, dynamic> body) async {
    try {
      await _apiService.post(path: "/api/impressoras", body: body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePrinter(Map<String, dynamic> body) async {
    try {
      await _apiService.put(path: "/api/impressoras", body: body);
    } catch (e) {
      rethrow;
    }
  }
}
