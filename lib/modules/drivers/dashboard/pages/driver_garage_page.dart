import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_garage_controller.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

import 'driver_add_new_vehicle_page.dart';

class DriverGaragePage extends GetView<DriverGarageController> {
  const DriverGaragePage({Key? key}) : super(key: key);
  static const id = '/DriverGarage';

  @override
  Widget build(BuildContext context) {
    return GetX<DriverGarageController>(
      initState: (state) {},
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.all(10.h),
              child: controller.haveVehicle.value
                  ? SingleChildScrollView(
                      child: Column(
                        children: [],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No Vehicle Found',
                            style: AppTextStyles.textStyleBoldBodyMedium,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(DriverAddNewVehiclePage.id);
                            },
                            child: Text(
                              'Add new one?',
                              style: AppTextStyles.textStyleBoldBodyMedium
                                  .copyWith(color: AppColor.primaryBlueColor),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
