import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';
import 'package:stocks_tracker/navigation/route_names.dart';
import 'package:stocks_tracker/themes/custom_colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ImageHelper.getImage(ImageNames.bgAll).image,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Profile',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 30),
              ImageHelper.getImage(
                ImageNames.avatar,
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 50),
              CustomProfileButton(
                text: 'Setting',
                icon: Icons.chevron_right,
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteNames.setting);
                },
              ),
              const SizedBox(height: 20),
              CustomProfileButton(
                text: 'Rate us',
                icon: Icons.chevron_right,
                onPressed: () => showRating(),
              ),
              const SizedBox(height: 20),
              CustomProfileButton(
                text: 'Change password',
                icon: Icons.lock,
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteNames.changePassword);
                },
              ),
              const SizedBox(height: 20),
              CustomProfileButton(
                text: 'Help and Feedback',
                icon: Icons.chevron_right,
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteNames.feedbackView);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showRating() async {
    final inAppReview = InAppReview.instance;
    inAppReview.openStoreListing(appStoreId: '6474306281');
  }
}

class CustomProfileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  const CustomProfileButton({
    super.key,
    this.icon,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll(
            Theme.of(context)
                .extension<CustomColors>()!
                .beginPrimaryGradient!
                .withOpacity(0.4),
          ),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black),
            ),
            const Spacer(),
            Icon(
              icon,
              color: Theme.of(context)
                  .extension<CustomColors>()!
                  .beginPrimaryGradient,
            ),
          ],
        ),
      ),
    );
  }
}
