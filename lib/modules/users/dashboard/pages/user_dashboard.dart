import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../drivers/utils/styles.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        body: Stack(
          children: [
            Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColor.blackColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.1),
                    )
                  ],
                ),
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: GNav(
                      rippleColor: AppColor.alphaGrey,
                      hoverColor: AppColor.alphaGrey,
                      gap: 8,
                      activeColor: AppColor.whiteColor,
                      iconSize: 24,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      duration: const Duration(milliseconds: 400),
                      tabBackgroundColor:
                          AppColor.primaryBlueColor.withOpacity(0.5),
                      color: AppColor.whiteColor,
                      backgroundColor: AppColor.blackColor,
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
            ),
          ],
        ),
      ),
    );
  }

  static final List<Widget> _widgetOptions = <Widget>[
    Text(
      'Profile',
      style: AppTextStyles.textStyleBoldBodyMedium,
    ),
    Text(
      'Profile',
      style: AppTextStyles.textStyleBoldBodyMedium,
    ),
    Text(
      'Profile',
      style: AppTextStyles.textStyleBoldBodyMedium,
    ),
    Text(
      'Profile',
      style: AppTextStyles.textStyleBoldBodyMedium,
    ),
  ];
}
