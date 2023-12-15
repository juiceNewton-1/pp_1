import 'package:flutter/material.dart';
import 'package:stocks_tracker/navigation/route_names.dart';
import 'package:stocks_tracker/widgets/screens/change_password.dart';
import 'package:stocks_tracker/widgets/screens/company_list_view.dart';
import 'package:stocks_tracker/widgets/screens/create_password.dart';
import 'package:stocks_tracker/widgets/screens/favorites/view/favorites_view.dart';
import 'package:stocks_tracker/widgets/screens/feedbackView.dart';
import 'package:stocks_tracker/widgets/screens/news/view/new_view.dart';
import 'package:stocks_tracker/widgets/screens/news/view/news_view.dart';
import 'package:stocks_tracker/widgets/screens/onboarding.dart';
import 'package:stocks_tracker/widgets/screens/privacy_view.dart';
import 'package:stocks_tracker/widgets/screens/profile.dart';
import 'package:stocks_tracker/widgets/screens/setting_view.dart';
import 'package:stocks_tracker/widgets/screens/splash_view.dart';
import 'package:stocks_tracker/widgets/screens/stocks/view/stock_view.dart';
import 'package:stocks_tracker/widgets/screens/stocks/view/stocks_view.dart';

typedef ScreenBuilding = Widget Function(BuildContext);

class Routes {
  static Map<String, ScreenBuilding> get(BuildContext context) {
    return {
      RouteNames.onboarding: (context) => const OnboardingView(),
      RouteNames.createPassword: (context) => const CreatePasswordView(),
      RouteNames.companyList: (context) => const CompanyListView(),
      RouteNames.stocksView: (context) => const StocksView(),
      RouteNames.favoriteStocksView: (context) => const FavoriteStocksView(),
      RouteNames.newsView: (context) => const NewsView(),
      RouteNames.profileView: (context) => const ProfileView(),
      RouteNames.stockView: (context) => StockView.create(context),
      RouteNames.setting: (context) => const SettingView(),
      RouteNames.changePassword: (context) => const ChangePasswordView(),
      RouteNames.feedbackView: (context) => FeedbackView(),
      RouteNames.privacy: (context) => const PrivacyView(),
      RouteNames.splash: (context) => const SplashView(),
      RouteNames.newView: (context) => NewView.create(context),
    };
  }
}
