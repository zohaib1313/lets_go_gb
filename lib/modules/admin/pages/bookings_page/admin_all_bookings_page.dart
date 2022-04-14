// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_bookings_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../drivers/utils/styles.dart';
import 'admin_all_bookings_mobile.dart';
import 'admin_all_bookings_web.dart';

class AdminAllBookingsPage extends GetView<AdminViewAllBookingsController> {
  static const id = '/AdminAllBookingsPage';

  AdminAllBookingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.alphaGrey,
        body: GetX<AdminViewAllBookingsController>(
            initState: (state) {},
            builder: (context) {
              controller.temp.value;
              return ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  if (sizingInformation.deviceScreenType ==
                      DeviceScreenType.mobile) {
                    return AdminViewAllBookingsMobile();
                  } else {
                    return AdminViewAllBookingsWeb();
                  }
                },
              );
            }));
  }
}
