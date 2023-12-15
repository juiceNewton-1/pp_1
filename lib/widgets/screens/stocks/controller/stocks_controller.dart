import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stocks_tracker/helpers/constants.dart';
import 'package:stocks_tracker/models/stock.dart';
import 'package:stocks_tracker/service/stock_api_service.dart';

class StocksController extends ValueNotifier<StocksState> {
  StocksController() : super(StocksState.inital()) {
    _init();
  }

  final _stockApiService = GetIt.instance<StockApiService>();

  Future<void> _init() async {
    try {
      List<Stock> stocks = [];
      value = value.copyWith(isLoading: true);

      for (var index = 0; index < 10; index++) {
        final stock = await _stockApiService
            .getStock(Constants.stockSymbols[index].symbol);
        stocks.add(stock);
      }

      value = value.copyWith(isLoading: false, stocks: stocks, loadedCount: 10);
    } catch (e) {
      value = value.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refresh() async => await _init();

  Future<void> loadNextStockPage() async {
    if (value.loadedCount < Constants.stockSymbols.length) {
      value = value.copyWith(isNextPageLoading: true);
      final updatedLoadedCount = value.loadedCount + 10;
      List<Stock> stocks = [];
      for (var index = value.loadedCount; index < updatedLoadedCount; index++) {
        final stock = await _stockApiService
            .getStock(Constants.stockSymbols[index].symbol);
        stocks.add(stock);
      }
      final updatedStocks = value.stocks..addAll(stocks);
      value = value.copyWith(
        isNextPageLoading: false,
        loadedCount: updatedLoadedCount,
        stocks: updatedStocks,
      );
    } else {
      return;
    }
  }
}

class StocksState {
  List<Stock> stocks;
  final int loadedCount;
  final Stock? searched;
  final bool isLoading;
  final bool isNextPageLoading;
  final String? errorMessage;

  StocksState(
      {required this.stocks,
      required this.isLoading,
      required this.loadedCount,
      this.searched,
      this.errorMessage,
      this.isNextPageLoading = false});

  factory StocksState.inital() => StocksState(
        stocks: [],
        isLoading: false,
        loadedCount: 0,
      );

  StocksState copyWith({
    List<Stock>? stocks,
    Stock? searched,
    int? loadedCount,
    bool? isLoading,
    bool? isNextPageLoading,
    String? errorMessage,
  }) =>
      StocksState(
        loadedCount: loadedCount ?? this.loadedCount,
        stocks: stocks ?? this.stocks,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        searched: searched ?? this.searched,
        isNextPageLoading: isNextPageLoading ?? this.isNextPageLoading,
      );
}
