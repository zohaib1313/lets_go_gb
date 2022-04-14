// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/menu.dart';

import '../../../drivers/utils/styles.dart';
import '../../controller/admin_home_controller.dart';

class AdminHomeScreenWeb extends GetView<AdminHomeScreenController> {
  final vSpace = SizedBox(height: 20.h);

  AdminHomeScreenWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.alphaGrey,
        body: SafeArea(
          child: GetX<AdminHomeScreenController>(
            initState: (state) {},
            builder: (ct) {
              controller.temp.value;
              return Row(
                children: [
                  SizedBox(
                    width: context.width * 0.2,
                    child: MenuWidgetAdmin(),
                  ),
                  Expanded(
                    child: IndexedStack(
                        index: controller.selectedViewIndex.value,
                        children: controller.indexedStack),
                  )
                ],
              );
            },
          ),
        ));
  }
}
