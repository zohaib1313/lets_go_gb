import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_chat_page_home.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_more_page.dart';

import '../../utils/styles.dart';
import 'driver_garage_page.dart';
import 'home_page.dart';

class DriverDashBoard extends StatefulWidget {
  const DriverDashBoard({Key? key}) : super(key: key);

  @override
  _DriverDashBoardState createState() => _DriverDashBoardState();
}

class _DriverDashBoardState extends State<DriverDashBoard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Stack(
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
                          horizontal: 18, vertical: 12),
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
                          icon: Icons.car_rental,
                          text: 'Garage',
                        ),
                        GButton(
                          icon: Icons.chat_bubble_outline_outlined,
                          text: 'Chat',
                        ),
                        GButton(
                          icon: Icons.more_horiz,
                          text: 'More',
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
    const DriverHomePage(),
    DriverGaragePage(),
    const DriverChatHomePage(),
    const DriverMorePage(),
  ];
}
