import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_more_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/about_us_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/contact_us_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/privacy_policy_page.dart';
import 'package:let_go_gb/modules/drivers/utils/app_popups.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';

import '../../../../common/pages/login_page.dart';

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
                    Column(
                      children: [
                        getRowItem(
                            title: 'Privacy Policy',
                            icon: Icons.privacy_tip_outlined,
                            onTap: () {
                              Get.toNamed(PrivacyPolicyPage.id);
                            }),
                        getRowItem(
                            title: 'About Us',
                            icon: Icons.info_outline,
                            onTap: () {
                              Get.toNamed(AboutUsPage.id);
                            }),
                        getRowItem(
                            title: 'Contact Us',
                            icon: Icons.contact_mail_outlined,
                            onTap: () {
                              Get.toNamed(ContactUsPage.id);
                            }),
                        getRowItem(
                            title: 'Sign out',
                            icon: Icons.logout,
                            onTap: () {
                              AppPopUps.showAlertDialog(
                                  message: 'Are you sure to logout?',
                                  onSubmit: () {
                                    UserDefaults().clearAll();
                                    Get.offAllNamed(LoginPage.id);
                                  });
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  getRowItem({required String title, required IconData icon, onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 35.w,
            ),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
