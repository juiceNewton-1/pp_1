import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stocks_tracker/service/database/entities/stock_entity.dart';

class DatabaseService {
  late Box _common;
  late Box<StockEntity> _favorites;
  Future<DatabaseService> init() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
    Hive.registerAdapter(StockEntityAdapter());
    Hive.registerAdapter(MetaDataEntityAdapter());
    Hive.registerAdapter(StockValueEntityAdapter());
    _common = await Hive.openBox('common');
    _favorites = await Hive.openBox('favorites');
    return this;
  }

  List<StockEntity> get favorites => _favorites.values.toList();

  Stream<BoxEvent> get favoritesStream => _favorites.watch();

  void put(String key, dynamic value) => _common.put(key, value);

  dynamic get(String key) => _common.get(key);

  void delete(String key) => _common.delete(key);

  void addToFavorites(StockEntity value) => _favorites.add(value);

  void removeFromFavorites(int index) => _favorites.deleteAt(index);
}
