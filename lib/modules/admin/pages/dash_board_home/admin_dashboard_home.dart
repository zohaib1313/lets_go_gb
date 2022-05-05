// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../drivers/utils/styles.dart';
import '../../controller/admin_dashboard_home_controller.dart';
import 'admin_dashboard_home_mobile.dart';
import 'admin_dashboard_home_web.dart';

class AdminDashboardHome extends GetView<AdminDashBoardHomeController> {
  static const id = '/AdminDashboardHome';

  AdminDashboardHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.alphaGrey,
        body: GetX<AdminDashBoardHomeController>(
            initState: (state) {},
            builder: (context) {
              controller.temp.value;
              return ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  if (sizingInformation.deviceScreenType ==
                      DeviceScreenType.mobile) {
                    return AdminDashboardHomeMobile();
                  } else {
                    return AdminDashboardHomeWeb();
                  }
                },
              );
            }));
  }
}
