import 'package:flutter/material.dart';
import 'package:stocks_tracker/themes/custom_colors.dart';



class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.width,
    this.height,
    this.onTap,
    this.color,
  });

  final String text;
  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.00, -1.00),
              end: const Alignment(0, 1),
              colors: [
                Theme.of(context)
                    .extension<CustomColors>()!
                    .beginPrimaryGradient!,
                Theme.of(context)
                    .extension<CustomColors>()!
                    .endPrimaryGradient!,
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
