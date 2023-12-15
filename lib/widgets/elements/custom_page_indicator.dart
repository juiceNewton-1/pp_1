import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageIndicator extends StatelessWidget {
  final PageController pageController;
  final int count;
  final double height;
  final Color? activeColor;

  const CustomPageIndicator({
    Key? key,
    required this.pageController,
    required this.count,
    required this.height,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: count,
      effect: SlideEffect(
        radius: 0,
        dotHeight: height,
        activeDotColor: activeColor ?? Colors.indigo,
      ),
    );
  }
}
