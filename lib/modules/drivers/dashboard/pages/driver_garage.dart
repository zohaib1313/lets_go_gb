import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_garage_controller.dart';

class DriverGarage extends GetView<DriverGarageController> {
  const DriverGarage({Key? key}) : super(key: key);
  static const id = '/DriverGarage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetX<DriverGarageController>(
      initState: (state) {},
      builder: (_) {
        controller.temp.value;
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(10.h),
            child: SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          ),
        );
      },
    ));
  }
}
