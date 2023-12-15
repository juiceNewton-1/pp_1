import 'package:flutter/material.dart';
import 'package:stocks_tracker/helpers/constants.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';
import 'package:stocks_tracker/models/arguments.dart';
import 'package:stocks_tracker/navigation/route_names.dart';
import 'package:stocks_tracker/widgets/elements/stock_card.dart';
import 'package:stocks_tracker/widgets/screens/favorites/controller/favorites_controller.dart';

class FavoriteStocksView extends StatefulWidget {
  const FavoriteStocksView({super.key});

  @override
  State<FavoriteStocksView> createState() => _FavoriteStocksViewState();
}

class _FavoriteStocksViewState extends State<FavoriteStocksView> {
  final _favoritesController = FavoritesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ImageHelper.getImage(ImageNames.bgAll).image,
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'Favourites',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: _favoritesController,
                  builder: (context, value, child) => value.favorites.isEmpty
                      ? const SizedBox.shrink()
                      : ListView.separated(
                          itemCount: value.favorites.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 24),
                          itemBuilder: (context, index) {
                            final symbol = Constants.stockSymbols.firstWhere(
                                (element) =>
                                    element.symbol ==
                                    value.favorites[index].metaData.symbol);
                            return StockCard(
                              stock: value.favorites[index],
                              symbol: symbol,
                              onPressed: () => Navigator.of(context).pushNamed(
                                RouteNames.stockView,
                                arguments: StockViewArguments(
                                  stock: value.favorites[index],
                                  symbol: symbol,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
