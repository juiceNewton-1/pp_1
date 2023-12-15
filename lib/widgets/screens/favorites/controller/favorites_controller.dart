import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:stocks_tracker/models/stock.dart';
import 'package:stocks_tracker/service/database/database_service.dart';

class FavoritesController extends ValueNotifier<FavoritesState> {
  final _databaseService = GetIt.instance<DatabaseService>();

  FavoritesController() : super(FavoritesState.inital()) {
    _init();
  }

  void _init() {
    final favorites =
        _databaseService.favorites.map((e) => Stock.fromEntity(e)).toList();
    value = value.copyWith(favorites: favorites);
    _databaseService.favoritesStream.listen(_handleUpdates);
  }

  void _handleUpdates(BoxEvent boxEvent) {
    final favorites =
        _databaseService.favorites.map((e) => Stock.fromEntity(e)).toList();
    value = value.copyWith(favorites: favorites);
  }
}

class FavoritesState {
  final List<Stock> favorites;
  const FavoritesState({required this.favorites});

  factory FavoritesState.inital() => const FavoritesState(favorites: []);

  FavoritesState copyWith({List<Stock>? favorites}) => FavoritesState(
        favorites: favorites ?? this.favorites,
      );
}
