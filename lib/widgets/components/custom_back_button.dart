import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: Navigator.of(context).pop,
        borderRadius: BorderRadius.circular(20),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
