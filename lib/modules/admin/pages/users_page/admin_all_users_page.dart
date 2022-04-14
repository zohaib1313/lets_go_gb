// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../drivers/utils/styles.dart';
import '../../controller/admin_view_all_users_controller.dart';
import 'admin_all_users_mobile.dart';
import 'admin_all_users_web.dart';

class AdminAllUsersPage extends GetView<AdminViewAllUsersController> {
  static const id = '/AdminAllUsersPage';

  AdminAllUsersPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.alphaGrey,
        body: GetX<AdminViewAllUsersController>(
            initState: (state) {},
            builder: (context) {
              controller.temp.value;
              return ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  if (sizingInformation.deviceScreenType ==
                      DeviceScreenType.mobile) {
                    return AdminViewAllUsersMobile();
                  } else {
                    return AdminViewAllUsersWeb();
                  }
                },
              );
            }));
  }
}
