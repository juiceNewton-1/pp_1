import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';

class SplashLoading extends StatelessWidget {
  const SplashLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ImageHelper.getImage(ImageNames.onboarding_1).image,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: CupertinoActivityIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
