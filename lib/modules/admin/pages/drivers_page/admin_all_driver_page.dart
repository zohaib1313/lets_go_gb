// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_drivers_controller.dart';
import 'package:let_go_gb/modules/admin/pages/drivers_page/admin_all_drivers_mobile.dart';
import 'package:let_go_gb/modules/admin/pages/drivers_page/admin_all_drivers_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../drivers/utils/styles.dart';

class AdminAllDriversPage extends GetView<AdminViewAllDriversController> {
  static const id = '/AdminAllDriversPage';

  AdminAllDriversPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.alphaGrey,
        body: GetX<AdminViewAllDriversController>(
            initState: (state) {},
            builder: (context) {
              controller.temp.value;
              return ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  if (sizingInformation.deviceScreenType ==
                      DeviceScreenType.mobile) {
                    return AdminViewAllDriversMobile();
                  } else {
                    return AdminViewAllDriversWeb();
                  }
                },
              );
            }));
  }
}
