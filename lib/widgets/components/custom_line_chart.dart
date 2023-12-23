import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stocks_tracker/models/stock.dart';
import 'package:stocks_tracker/themes/custom_colors.dart';

class CustomLineChart extends StatelessWidget {
  final Stock stock;
  const CustomLineChart({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final mappedData = stock.values.map((e) => double.parse(e.close)).toList();
    final prices =
        mappedData.getRange(mappedData.length - 10, mappedData.length).toList();
    final sortedPrices = prices..sort();
    return LineChart(
      LineChartData(
        minX: 0,
        maxY: sortedPrices.last,
        titlesData: getTitleData(context),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.white,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return buildStylizedTooltip(lineBarsSpot, context);
            },
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(prices.length, (index) {
              log(prices[index].toString());
              return FlSpot(
                index.toDouble(),
                prices[index],
              );
            }),
            barWidth: 3,
            color: Theme.of(context).extension<CustomColors>()!.diagramLine,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: getStylizedGradient(context),
            ),
          ),
        ],
        gridData: const FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
        ),
      ),
    );
  }

  LinearGradient getStylizedGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(context)
            .extension<CustomColors>()!
            .diagramGradient!
            .withOpacity(1),
        Theme.of(context)
            .extension<CustomColors>()!
            .diagramGradient!
            .withOpacity(0.1),
      ],
    );
  }

  FlTitlesData getTitleData(BuildContext context) {
    return FlTitlesData(
      leftTitles: (AxisTitles(
        sideTitles: SideTitles(
          // interval: 1,
          reservedSize: 45,
          getTitlesWidget: (value, meta) {
            return SideTitleWidget(
              axisSide: meta.axisSide,
              child: Text(
                meta.formattedValue,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Theme.of(context)
                          .extension<CustomColors>()!
                          .colorExtraLine!
                          .withOpacity(0.8),
                    ),
              ),
            );
          },
          showTitles: true,
        ),
      )),
      bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  List<LineTooltipItem> buildStylizedTooltip(
      List<LineBarSpot> lineBarsSpot, BuildContext context) {
    return lineBarsSpot.map(
      (LineBarSpot touchedSpot) {
        String points = '\$${touchedSpot.y}';
        final TextStyle textStyle = Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: Theme.of(context).colorScheme.secondary);
        return LineTooltipItem(points, textStyle);
      },
    ).toList();
  }
}
