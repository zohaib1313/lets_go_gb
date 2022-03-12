import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:let_go_gb/modules/drivers/home/pages/home_screen_driver.dart';
import 'package:let_go_gb/modules/drivers/home/pages/hot_deals_page.dart';
import 'package:let_go_gb/modules/drivers/home/pages/search_screen.dart';

import '../../utils/styles.dart';

class DriverDashBoard extends StatefulWidget {
  const DriverDashBoard({Key? key}) : super(key: key);

  @override
  _DriverDashBoardState createState() => _DriverDashBoardState();
}

class _DriverDashBoardState extends State<DriverDashBoard> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreenDriver(),
    HotDealsPage(),
    SearchDriverScreen(),
    Text(
      'Profile',
      style: AppTextStyles.textStyleBoldBodyMedium,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GNav(
                    rippleColor: AppColor.alphaGrey,
                    hoverColor: AppColor.alphaGrey,
                    gap: 8,
                    activeColor: AppColor.primaryBlueColor,
                    iconSize: 24,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    duration: const Duration(milliseconds: 400),
                    tabBackgroundColor: AppColor.alphaGrey,
                    color: AppColor.blackColor,
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.favorite,
                        text: 'Likes',
                      ),
                      GButton(
                        icon: Icons.search,
                        text: 'Search',
                      ),
                      GButton(
                        icon: Icons.person_outline,
                        text: 'Profile',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
