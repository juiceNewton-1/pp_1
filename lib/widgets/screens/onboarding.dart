import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';
import 'package:stocks_tracker/helpers/text_helper.dart';
import 'package:stocks_tracker/navigation/route_names.dart';
import 'package:stocks_tracker/service/database/database_keys.dart';
import 'package:stocks_tracker/service/database/database_service.dart';
import 'package:stocks_tracker/themes/custom_colors.dart';
import 'package:stocks_tracker/widgets/components/custom_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _databaseService = GetIt.instance<DatabaseService>();
  final pageController = PageController();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _databaseService.put(DatabaseKeys.seenOnboarding, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: 5,
        itemBuilder: (_, index) => Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ImageHelper.getImage(getBgOnboarding(index)).image,
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.only(left: 24, right: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: index < 4 ? 3 : 4),
                  Text(
                    _getText(index),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  LastOnboardingView(index: index),
                  Text(
                    _getSubtext(index),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.white.withOpacity(0.5)),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Positioned(
              right: 40,
              bottom: 50,
              child: Visibility(
                visible: index != 4,
                child: CustomPageIndicator(
                  pageController: pageController,
                  count: 4,
                  height: 5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getBgOnboarding(index) {
    if (index == 0) {
      return ImageNames.onboarding_1;
    } else if (index == 1) {
      return ImageNames.onboarding_2;
    } else if (index == 2) {
      return ImageNames.onboarding_3;
    } else if (index == 3) {
      return ImageNames.onboarding_4;
    } else if (index == 4) {
      return ImageNames.onboarding_1;
    } else {
      return '';
    }
  }

  String _getText(index) {
    if (index == 0) {
      return 'Track your\nstock with us!';
    } else if (index == 1) {
      return 'Manage\nyour wallet!';
    } else if (index == 2) {
      return 'Stay Ahead,\nChart Your\nCourse: Trading\nwith Insight!';
    } else if (index == 3) {
      return 'Monitor stocks';
    } else {
      return '';
    }
  }

  String _getSubtext(index) {
    if (index == 0) {
      return 'keep track of changes.';
    } else if (index == 1) {
      return 'Empower Your Finances: Master Your Wallet!';
    } else if (index == 3) {
      return 'Watch the charts in real time!';
    } else {
      return '';
    }
  }
}

class LastOnboardingView extends StatelessWidget {
  final int index;
  const LastOnboardingView({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: index == 4,
      child: Center(
        child: Column(
          children: [
            Text(
              'Lets get Started',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 15),
            Text(
              TextHelper.lastTextOnboarding,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: 60),
            SlideAction(
              onSubmit: () => Navigator.of(context)
                  .pushReplacementNamed(RouteNames.createPassword),
              innerColor: Theme.of(context)
                  .extension<CustomColors>()!
                  .colorCliderIcon!
                  .withOpacity(0.7),
              outerColor: Colors.white.withOpacity(0.4),
              text: '',
              submittedIcon: const Icon(Icons.chevron_right),
              sliderButtonIcon: Icon(
                Icons.chevron_right,
                size: 25,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
