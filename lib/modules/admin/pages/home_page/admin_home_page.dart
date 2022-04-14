// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/pages/home_page/admin_home_web_view_.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../drivers/utils/styles.dart';
import '../../controller/admin_home_controller.dart';
import 'admin_home_mobile_view.dart';

class AdminHomePage extends GetView<AdminHomeScreenController> {
  static const id = '/AdminHomeScreen';
  final vSpace = SizedBox(height: 20.h);

  AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.alphaGrey,
        body: SafeArea(
          child: GetX<AdminHomeScreenController>(
              initState: (state) {},
              builder: (context) {
                controller.temp.value;
                return ResponsiveBuilder(
                  builder: (context, sizingInformation) {
                    if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.mobile) {
                      return AdminHomeScreenMobileView();
                    } else {
                      return AdminHomeScreenWeb();
                    }
                  },
                );
              }),
        ));
  }
}
