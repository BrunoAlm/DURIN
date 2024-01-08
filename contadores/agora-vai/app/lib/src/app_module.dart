
import 'package:app/main.dart';
import 'package:app/src/core/api_service.dart';
import 'package:app/src/pages/features/printers/printers_repository.dart';
import 'package:app/src/pages/features/printers/printers_controller.dart';
import 'package:app/src/pages/features/reports/reports_controller.dart';
import 'package:app/src/pages/navigation_store.dart';

class AppModule {
  static void start() {
    // Services
    di.registerFactory(() => ApiService());

    // Repositories
    di.registerFactory<PrintersRepository>(() => PrintersRepositoryV1(di()));

    // Controllers || Stores
    di.registerLazySingleton(() => PrintersController());
    di.registerFactory(() => NavigationStore());
    di.registerFactory(() => ReportsController());
  }
}