import 'package:hive/hive.dart';
import 'package:stocks_tracker/models/stock.dart';

part 'stock_entity.g.dart';

@HiveType(typeId: 0)
class StockEntity extends HiveObject {
  @HiveField(0)
  final MetaDataEntity metaData;
  @HiveField(1)
  final List<StockValueEntity> values;

  StockEntity({required this.metaData, required this.values});

  factory StockEntity.fromStock(Stock stock) => StockEntity(
      metaData: MetaDataEntity.fromMetaData(stock.metaData),
      values:
          stock.values.map((e) => StockValueEntity.fromStockValue(e)).toList());
}

@HiveType(typeId: 1)
class MetaDataEntity extends HiveObject {
  @HiveField(0)
  final String information;
  @HiveField(1)
  final String symbol;

  MetaDataEntity({
    required this.information,
    required this.symbol,
  });

  factory MetaDataEntity.fromMetaData(MetaData metaData) => MetaDataEntity(
        information: metaData.information,
        symbol: metaData.symbol,
      );
}

@HiveType(typeId: 2)
class StockValueEntity extends HiveObject {
  @HiveField(0)
  final String close;

  StockValueEntity({
    required this.close,
  });

  factory StockValueEntity.fromStockValue(StockValue stockValue) =>
      StockValueEntity(close: stockValue.close);
}
