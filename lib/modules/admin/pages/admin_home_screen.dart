// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../drivers/utils/styles.dart';
import '../controller/admin_home_controller.dart';

class AdminHomeScreen extends GetView<AdminHomeScreenController> {
  static const id = '/AdminHomeScreen';
  final vSpace = SizedBox(height: 20.h);

  AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.alphaGrey,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: 50.w,
              right: 50.w,
            ),
            child: GetX<AdminHomeScreenController>(
                initState: (state) {},
                builder: (context) {
                  controller.temp.value;
                  return Container(
                    child: Center(
                      child: Text('Admin'),
                    ),
                  );
                }),
          ),
        ));
  }
}
