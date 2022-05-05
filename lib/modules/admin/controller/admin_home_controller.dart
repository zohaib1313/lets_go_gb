import 'package:flutter/cupertino.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/pages/chat_all_home_page.dart';
import 'package:let_go_gb/common/pages/notifications_page.dart';
import 'package:let_go_gb/modules/admin/pages/bookings_page/admin_all_bookings_page.dart';
import 'package:let_go_gb/modules/admin/pages/dash_board_home/admin_dashboard_home.dart';
import 'package:let_go_gb/modules/admin/pages/drivers_page/admin_all_driver_page.dart';
import 'package:let_go_gb/modules/admin/pages/promoted_vehicles/promoted_vehicles_page.dart';
import 'package:let_go_gb/modules/admin/pages/users_page/admin_all_users_page.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

import '../pages/blogs_page/admin_all_blogs_page.dart';

class AdminHomeScreenController extends GetxController {
  var temp = 0.obs;
  final zoomDrawerController = ZoomDrawerController();

  var selectedViewIndex = 0.obs;
  List<Widget> indexedStack = [
    AdminDashboardHome(),
    AdminAllDriversPage(),
    AdminViewAllBlogsPage(),
    AdminViewAllUsersPage(),
    AdminViewAllBookingsPage(),
    NotificationsPage(),
    ChatAllHomePage(),
    PromotedAdsPage(),
  ];

  void toggleDrawer() {
    printWrapped("Toggle drawer");
    zoomDrawerController.toggle?.call();
  }
}
