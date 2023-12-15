import 'package:get_it/get_it.dart';
import 'package:stocks_tracker/service/database/database_service.dart';
import 'package:stocks_tracker/service/local_auth.dart';
import 'package:stocks_tracker/service/news_api_service.dart';
import 'package:stocks_tracker/service/remote_config_service.dart';
import 'package:stocks_tracker/service/stock_api_service.dart';
import 'package:stocks_tracker/service/storage/storage_service.dart';

class ServiceLocator {
  static Future<void> setup() async {
    final storageService = StorageService();
    GetIt.I.registerSingleton<StorageService>(storageService);
    await storageService.init();
    GetIt.I.registerSingletonAsync(() => DatabaseService().init());
    await GetIt.I.isReady<DatabaseService>();
    GetIt.I.registerLazySingleton<LocalAuth>(() => LocalAuth());
    GetIt.I.registerSingleton<StockApiService>(StockApiService());
    GetIt.I.registerSingleton<NewsApiService>(NewsApiService());
    GetIt.I.registerSingletonAsync(() => RemoteConfigService().init());
    await GetIt.I.isReady<RemoteConfigService>();
  }
}
