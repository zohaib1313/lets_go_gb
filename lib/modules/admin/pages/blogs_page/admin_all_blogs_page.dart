// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_blogs_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../drivers/utils/styles.dart';
import 'admin_all_blogs_mobile.dart';
import 'admin_all_blogs_web.dart';

class AdminViewAllBlogsPage extends GetView<AdminViewAllBlogsController> {
  static const id = '/AdminAllBlogsPage';

  AdminViewAllBlogsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.alphaGrey,
        body: GetX<AdminViewAllBlogsController>(
            initState: (state) {},
            builder: (context) {
              controller.temp.value;
              return ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  if (sizingInformation.deviceScreenType ==
                      DeviceScreenType.mobile) {
                    return AdminViewAllBlogsMobile();
                  } else {
                    return AdminViewAllBlogsPageWeb();
                  }
                },
              );
            }));
  }
}
