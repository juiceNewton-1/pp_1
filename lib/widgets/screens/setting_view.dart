import 'package:flutter/material.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';
import 'package:stocks_tracker/helpers/text_helper.dart';
import 'package:stocks_tracker/widgets/elements/custom_back_button.dart';
import 'package:stocks_tracker/widgets/screens/profile.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ImageHelper.getImage(ImageNames.bgAll).image,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CustomBackButton(),
                  const Spacer(flex: 2),
                  Text(
                    'Setting',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const Spacer(flex: 3),
                ],
              ),
              const SizedBox(height: 20),
              CustomProfileButton(
                text: 'Privacy',
                icon: Icons.chevron_right,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: SingleChildScrollView(
                        child: Text(
                          TextHelper.privacyText,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomProfileButton(
                text: 'Terms',
                icon: Icons.chevron_right,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: SingleChildScrollView(
                        child: Text(
                          TextHelper.terms,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
