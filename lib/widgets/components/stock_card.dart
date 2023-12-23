import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_tracker/models/stock.dart';
import 'package:stocks_tracker/models/stock_symbol.dart';

class StockCard extends StatelessWidget {
  final Stock stock;
  final StockSymbol symbol;
  final VoidCallback? onPressed;
  const StockCard({
    super.key,
    this.onPressed,
    required this.stock,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    final priceChange = stock.getPriceChange();
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 55,
            height: 55,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: symbol.icon.svg(fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(stock.metaData.symbol),
              Text(
                symbol.info,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )),
          Column(
            children: [
              Text(stock.values.last.close),
              Row(
                children: [
                  priceChange.isNegative
                      ? const Icon(
                          Icons.expand_more,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.expand_less,
                          color: Colors.green,
                        ),
                  Text(
                    '${priceChange.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: priceChange.isNegative ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
