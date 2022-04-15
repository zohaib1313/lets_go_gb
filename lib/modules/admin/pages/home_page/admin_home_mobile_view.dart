// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/menu.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

import '../../controller/admin_home_controller.dart';

class AdminHomeScreenMobileView extends GetView<AdminHomeScreenController> {
  AdminHomeScreenMobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AdminHomeScreenController>(
      initState: (state) {},
      builder: (cc) {
        controller.temp.value;
        return ZoomDrawer(
          controller: controller.zoomDrawerController,
          menuScreen: MenuWidgetAdmin(),
          style: DrawerStyle.style4,
          mainScreen: MainScreen(),
          borderRadius: 24.0,
          showShadow: true,
          angle: 0.0,
          drawerShadowsBackgroundColor: Colors.grey,
          slideWidth: MediaQuery.of(context).size.width * 0.65,
        );
      },
    );
  }
}

class MainScreen extends GetView<AdminHomeScreenController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.greenColor,
        leading: InkWell(
            onTap: () {
              controller.toggleDrawer();
            },
            child: Icon(Icons.menu)),
      ),
      body: Obx(
        () {
          controller.zoomDrawerController.close!();
          return IndexedStack(
              key: UniqueKey(),
              index: controller.selectedViewIndex.value,
              children: controller.indexedStack);
        },
      ),
    );
  }
}
