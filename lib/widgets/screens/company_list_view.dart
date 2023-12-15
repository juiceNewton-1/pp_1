import 'package:flutter/material.dart';
import 'package:stocks_tracker/themes/custom_colors.dart';
import 'package:stocks_tracker/widgets/screens/favorites/view/favorites_view.dart';
import 'package:stocks_tracker/widgets/screens/news/view/news_view.dart';
import 'package:stocks_tracker/widgets/screens/profile.dart';
import 'package:stocks_tracker/widgets/screens/stocks/view/stocks_view.dart';

class CompanyListView extends StatefulWidget {
  const CompanyListView({super.key});

  @override
  State<CompanyListView> createState() => _CompanyListViewState();
}

class _CompanyListViewState extends State<CompanyListView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        elevation: 0,
        iconSize: 30,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        fixedColor:
            Theme.of(context).extension<CustomColors>()!.beginPrimaryGradient!,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        onTap: (newIndex) {
          setState(
            () => _currentIndex = newIndex,
          );
        },
      ),
      body: [
        const StocksView(),
        const FavoriteStocksView(),
        const NewsView(),
        const ProfileView(),
      ][_currentIndex],
    );
  }
}
