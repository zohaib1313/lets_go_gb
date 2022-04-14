import 'package:flutter/cupertino.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/pages/dash_board_home/admin_dashboard_home.dart';
import 'package:let_go_gb/modules/admin/pages/drivers_page/admin_all_driver_page.dart';

import '../pages/blogs_page/admin_all_blogs_page.dart';

class AdminHomeScreenController extends GetxController {
  var temp = 0.obs;
  final zoomDrawerController = ZoomDrawerController();

  var selectedViewIndex = 0.obs;
  List<Widget> indexedStack = [
    AdminDashboardHome(),
    AdminAllDriversPage(),
    AdminViewAllBlogsPage()
  ];

  void toggleDrawer() {
    print("Toggle drawer");

    zoomDrawerController.toggle?.call();
  }
}
