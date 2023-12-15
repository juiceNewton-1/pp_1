import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';
import 'package:stocks_tracker/models/arguments.dart';
import 'package:stocks_tracker/widgets/elements/custom_back_button.dart';
import 'package:stocks_tracker/widgets/elements/custom_line_chart.dart';
import 'package:stocks_tracker/widgets/screens/stocks/controller/stock_controller.dart';

class StockView extends StatefulWidget {
  final StockViewArguments arguments;
  const StockView({super.key, required this.arguments});

  @override
  State<StockView> createState() => _StockViewState();

  factory StockView.create(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as StockViewArguments;
    return StockView(
      arguments: arguments,
    );
  }
}

class _StockViewState extends State<StockView> {
  late final _stockController = StockController(widget.arguments.stock);

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _stockController.getAboutData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ImageHelper.getImage(ImageNames.bgAll).image,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomBackButton(),
                    const Spacer(flex: 2),
                    Text(
                      _stockController.value.stock.metaData.symbol,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Spacer(flex: 2),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: _stockController,
                        builder: (context, value, child) {
                          return Center(
                            child: IconButton(
                              onPressed: _stockController.isInFavorites
                                  ? _stockController.removeFromFavorites
                                  : _stockController.addToFavorites,
                              icon: _stockController.isInFavorites
                                  ? const Icon(Icons.bookmark)
                                  : const Icon(Icons.bookmark_outline),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child:
                          widget.arguments.symbol.icon.svg(fit: BoxFit.cover),
                    ),
                    SizedBox(width: 10),
                    Text(
                      _stockController.value.stock.metaData.symbol,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  widget.arguments.symbol.info,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.white.withOpacity(0.5)),
                ),
                const SizedBox(height: 20),
                AspectRatio(
                  aspectRatio: 1.24,
                  child: CustomLineChart(
                    stock: _stockController.value.stock,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'About',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ValueListenableBuilder(
                  valueListenable: _stockController,
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else {
                      if (value.about != null) {
                        return Text(value.about!,
                            style: Theme.of(context).textTheme.labelSmall);
                      } else {
                        return Column(
                          children: [
                            Text(
                              'Some error has occured. Please, try again',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const SizedBox(height: 20),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: _stockController.getAboutData,
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            )
                          ],
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
