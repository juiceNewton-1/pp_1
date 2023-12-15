import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:stocks_tracker/service/database/entities/stock_entity.dart';

class Stock extends Equatable {
  final MetaData metaData;
  final List<StockValue> values;

  const Stock({required this.metaData, required this.values});

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
      metaData: MetaData.fromJson(json['Meta Data']),
      values: (json['Time Series (60min)'] as Map<String, dynamic>)
          .values
          .map((json) => StockValue.fromJson(json))
          .toList());

  @override
  List<Object?> get props => [
        metaData,
        values,
      ];

  factory Stock.fromEntity(StockEntity stockEntity) => Stock(
      metaData: MetaData.fromEntity(stockEntity.metaData),
      values: stockEntity.values.map((e) => StockValue.fromEntity(e)).toList());

  double getPriceChange() {
    final mappedValues = values.map((e) => double.parse(e.close)).toList();
    final prices = mappedValues.getRange(mappedValues.length-2, mappedValues.length);
    log(prices.toString());
    return ((prices.last - prices.first) / prices.first) * 100;
  }
}

class MetaData extends Equatable {
  final String information;
  final String symbol;
  // final String lastRefreshed;
  // final String interval;
  // final String outputSize;
  // final String timeZone;
  const MetaData({
    required this.information,
    required this.symbol,
    // required this.lastRefreshed,
    // required this.interval,
    // required this.outputSize,
    // required this.timeZone,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        information: json['1. Information'],
        symbol: json['2. Symbol'],
        // lastRefreshed: json['3. Last Refreshed'],
        // interval: json['4. Interval'],
        // outputSize: json['5. Output Size'],
        // timeZone: json['6. Time Zone'],
      );

  @override
  List<Object?> get props => [information, symbol];

  factory MetaData.fromEntity(MetaDataEntity metaDataEntity) => MetaData(
        information: metaDataEntity.information,
        symbol: metaDataEntity.symbol,
      );
}

class StockValue extends Equatable {
  final String close;

  const StockValue({
    required this.close,
  });

  factory StockValue.fromJson(Map<String, dynamic> json) {
    return StockValue(
      close: json['4. close'],
    );
  }

  @override
  List<Object?> get props => [close];

  factory StockValue.fromEntity(StockValueEntity stockValueEntity) =>
      StockValue(close: stockValueEntity.close);


  
}
