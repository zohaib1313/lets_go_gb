import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_more_controller.dart';
import 'package:let_go_gb/modules/drivers/sing_in/pages/login_driver_screen.dart';
import 'package:let_go_gb/modules/drivers/utils/app_popups.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

import '../../utils/common_widgets.dart';
import '../../utils/user_defaults.dart';

class DriverMorePage extends GetView<DriverMoreController> {
  const DriverMorePage({Key? key}) : super(key: key);
  static const id = '/DriverMorePage';

  @override
  Widget build(BuildContext context) {
    return GetX<DriverMoreController>(
      initState: (state) {},
      builder: (_) {
        controller.temp.value;
        return SafeArea(
          child: Scaffold(
              body: Container(
                  padding: EdgeInsets.all(20.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            AppPopUps.showAlertDialog(
                                message: 'Are you sure to exit?',
                                onSubmit: () {
                                  UserDefaults().clearAll();
                                  Get.offAllNamed(DriverSignInScreen.id);
                                });
                          },
                          child: Row(
                            children: [
                              const SvgViewer(
                                  svgPath: "assets/icons/ic_logout.svg"),
                              SizedBox(
                                width: 35.w,
                              ),
                              Expanded(
                                child: Text(
                                  "Sign out",
                                  style: AppTextStyles.textStyleBoldBodyMedium,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))),
        );
      },
    );
  }
}
