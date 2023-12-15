import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stocks_tracker/models/stock.dart';
import 'package:stocks_tracker/service/database/database_service.dart';
import 'package:stocks_tracker/service/database/entities/stock_entity.dart';
import 'package:stocks_tracker/service/stock_api_service.dart';

class StockController extends ValueNotifier<StockState> {
  StockController(Stock stock)
      : super(
          StockState(
            stock: stock,
            favorites: _databaseService.favorites
                .map((e) => Stock.fromEntity(e))
                .toList(),
          ),
        );

  static final _databaseService = GetIt.instance<DatabaseService>();
  final _stockApiService = GetIt.instance<StockApiService>();

  bool get isInFavorites => value.favorites.contains(value.stock);

  void addToFavorites() {
    _databaseService.addToFavorites(StockEntity.fromStock(value.stock));
    value.favorites.add(value.stock);
    notifyListeners();
  }

  void removeFromFavorites() {
    final stockIndex = value.favorites.indexOf(value.stock);
    _databaseService.removeFromFavorites(stockIndex);
    value.favorites.removeAt(stockIndex);
    notifyListeners();
  }

  Future<void> getAboutData() async {
    try {
      value = value.copyWith(isLoading: true);
      final about = await _stockApiService
          .getAboutInformation(value.stock.metaData.symbol);
      value = value.copyWith(isLoading: false, about: about);
    } catch (e) {
      value = value.copyWith(isLoading: false);
    }
  }
}

class StockState {
  final Stock stock;
  final bool isLoading;
  final List<Stock> favorites;
  final String? about;
  const StockState({
    required this.stock,
    required this.favorites,
    this.isLoading = false,
    this.about,
  });

  StockState copyWith({bool? isLoading, String? about}) => StockState(
        stock: stock,
        favorites: favorites,
        isLoading: isLoading ?? this.isLoading,
        about: about ?? this.about,
      );
}
