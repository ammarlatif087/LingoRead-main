import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:lingoread/Pages/favorite_Screen.dart';
import 'package:lingoread/Pages/shop.dart';
import 'package:lingoread/Pages/training_Screen.dart';

import '../Pages/home_screen.dart';
import '../Utils/constants.dart';

class BottomNav extends StatefulWidget {
  static String routeName = "/bottomNav";

  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: const <Widget>[
              HomeScreen(),
              Training(),

              Shop(),
              Favourites(),
              //   TrainingScreenWidget(),
              // const ShopScreen(),
              // const FavScreen(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController!.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              title: const Text('Home'),
              icon: const Icon(Icons.home_filled),
              activeColor: kButtonColor,
              inactiveColor: kButtonColor.withOpacity(0.3),
            ),
            BottomNavyBarItem(
              title: const Text('Train'),
              icon: const Icon(Icons.note_alt_sharp),
              activeColor: kButtonColor,
              inactiveColor: kButtonColor.withOpacity(0.3),
            ),
            BottomNavyBarItem(
              title: const Text('Shop'),
              icon: const Icon(Icons.shopping_cart),
              activeColor: kButtonColor,
              inactiveColor: kButtonColor.withOpacity(0.3),
            ),
            BottomNavyBarItem(
              title: const Text('Favorite'),
              icon: const Icon(Icons.favorite),
              activeColor: kButtonColor,
              inactiveColor: kButtonColor.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}
