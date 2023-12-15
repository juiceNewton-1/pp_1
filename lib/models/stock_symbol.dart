import 'package:stocks_tracker/generated/assets.gen.dart';

class StockSymbol {
  final String symbol;
  final SvgGenImage icon;
  final String info;

  const StockSymbol({
    required this.symbol,
    required this.icon,
    required this.info,
  });
}
