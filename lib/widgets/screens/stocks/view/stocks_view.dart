import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_tracker/helpers/constants.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';
import 'package:stocks_tracker/models/arguments.dart';
import 'package:stocks_tracker/models/stock.dart';
import 'package:stocks_tracker/navigation/route_names.dart';
import 'package:stocks_tracker/themes/custom_colors.dart';
import 'package:stocks_tracker/widgets/components/custom_page_indicator.dart';
import 'package:stocks_tracker/widgets/components/stock_card.dart';
import 'package:stocks_tracker/widgets/screens/stocks/controller/stocks_controller.dart';

class StocksView extends StatefulWidget {
  const StocksView({super.key});

  @override
  State<StocksView> createState() => _StocksViewState();
}

class _StocksViewState extends State<StocksView> {
  final _stocksController = StocksController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ImageHelper.getImage(ImageNames.bgAll).image,
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Stock',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 20),
              FrameNews(),
              const SizedBox(height: 20),
              Text(
                'Market',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: _stocksController,
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return const _LoadingState();
                    } else if (value.errorMessage != null) {
                      return _ErrorState(
                        errorMessage: value.errorMessage!,
                        refresh: _stocksController.refresh,
                      );
                    } else {
                      final stocks = value.searched != null
                          ? [value.searched!]
                          : value.stocks;
                      return _LoadedState(
                        stocks: stocks,
                        isNextPageLoading: value.isNextPageLoading,
                        loadNextStockPage: _stocksController.loadNextStockPage,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 20,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? refresh;
  const _ErrorState({required this.errorMessage, this.refresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Error has occured: $errorMessage',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 20),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: refresh,
          child: const Icon(Icons.refresh_outlined, size: 30),
        ),
      ],
    );
  }
}

class _LoadedState extends StatelessWidget {
  final List<Stock> stocks;
  final bool isNextPageLoading;
  final VoidCallback loadNextStockPage;

  const _LoadedState({
    required this.stocks,
    required this.isNextPageLoading,
    required this.loadNextStockPage,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        final metrices = notification.metrics;
        if (metrices.pixels >= metrices.maxScrollExtent &&
            !isNextPageLoading &&
            stocks.length < Constants.stockSymbols.length) {
          loadNextStockPage.call();
        }

        return false;
      },
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 20),
        itemBuilder: (context, index) {
          final isLastPosition = index == stocks.length;
          if (isLastPosition) {
            if (isNextPageLoading) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          } else {
            final position = min(index, 49);
            return StockCard(
              stock: stocks[index],
              onPressed: () => Navigator.of(context).pushNamed(
                RouteNames.stockView,
                arguments: StockViewArguments(
                  stock: stocks[position],
                  symbol: Constants.stockSymbols[position],
                ),
              ),
              symbol: Constants.stockSymbols[position],
            );
          }
        },
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemCount: stocks.length + 1,
      ),
    );
  }
}

class FrameNews extends StatelessWidget {
  final _pageController = PageController();
  FrameNews({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.56,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: [
              Theme.of(context)
                  .extension<CustomColors>()!
                  .beginPrimaryGradient!,
              Theme.of(context).extension<CustomColors>()!.endPrimaryGradient!,
            ],
          ),
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemBuilder: (_, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getText(index),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Spacer(),
                        Text(
                          _getSubtext(index),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.white.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Expanded(child: ImageHelper.getImage(_getImage(index))),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 7,
              child: CustomPageIndicator(
                pageController: _pageController,
                count: 3,
                height: 3,
                activeColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getImage(index) {
    if (index == 0) {
      return ImageNames.news_1;
    } else if (index == 1) {
      return ImageNames.news_2;
    } else if (index == 2) {
      return ImageNames.news_3;
    } else {
      return '';
    }
  }

  String _getText(index) {
    if (index == 0) {
      return 'Check out\nthe latest stock news';
    } else if (index == 1) {
      return 'Track your\nstock with us!';
    } else if (index == 2) {
      return 'Track your stock\nwith us!';
    } else {
      return '';
    }
  }

  String _getSubtext(index) {
    if (index == 0) {
      return 'Find out more about\npromotions and benefits!';
    } else if (index == 1) {
      return 'Empower Your Finances:\nMaster Your Wallet!';
    } else if (index == 2) {
      return 'keep track of changes.';
    } else {
      return '';
    }
  }
}
