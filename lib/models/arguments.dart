import 'package:stocks_tracker/models/news.dart';
import 'package:stocks_tracker/models/stock.dart';
import 'package:stocks_tracker/models/stock_symbol.dart';

class StockViewArguments {
  final Stock stock;
  final StockSymbol symbol;

  const StockViewArguments({
    required this.stock,
    required this.symbol,
  });
}

class NewViewArguments {
  final News article;

  const NewViewArguments({required this.article});
}
